import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:CleanLauncher/model/appData.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:CleanLauncher/stores/StoreBuilder.dart';
import 'package:CleanLauncher/stores/favorites.dart';

import 'package:CleanLauncher/widgets/launcher/apps_list.dart';

final Favorites favorites = StoreBuilder.favorites();

class LauncherApps extends StatefulWidget {
  AppData highlighted = null;

  @override
  _LauncherAppsState createState() => _LauncherAppsState();
}

class _LauncherAppsState extends State<LauncherApps> {
  //
  void _onSettings() => Navigator.pushNamed(context, '/preferences');
  void _onSearch() => Navigator.pushNamed(context, '/search');

  void _onHighlight(AppData appData) {
    setState(() {
      widget.highlighted = appData;
    });
  }

  TextField _getRenameField() {
    Color normalColor = Theme.of(context).textTheme.headline3.color;
    OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: new BorderSide(color: normalColor),
    );
    return TextField(
      controller: TextEditingController(
        text: widget.highlighted.appName,
      ),
      autofocus: true,
      onChanged: (value) {
        widget.highlighted.appName = value;
      },
      decoration: InputDecoration(
        border: inputBorder,
        focusedBorder: inputBorder,
        disabledBorder: inputBorder,
        enabledBorder: inputBorder,
        labelText: "Rename",
        labelStyle: TextStyle(color: normalColor),
      ),
    );
  }

  void _onRename(BuildContext context) {
    Color highlightColor = Theme.of(context).textTheme.caption.color;
    if (widget.highlighted != null) {
      showDialog(
        context: context,
        child: AlertDialog(
          content: _getRenameField(),
          actions: <Widget>[
            OutlineButton(
              borderSide: BorderSide(color: highlightColor),
              child: Text(
                "DONE",
                style: TextStyle(color: highlightColor),
              ),
              onPressed: () => favorites.rename(widget.highlighted).then(
                    (_) => {
                      setState(() {
                        widget.highlighted = null;
                        Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pop();
                      })
                    },
                  ),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Color highlightColor = Theme.of(context).textTheme.caption.color;

    return Scaffold(
      appBar: AppBar(
        leading: widget.highlighted == null
            ? Container()
            : Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      color: highlightColor,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.highlighted = null;
                      });
                    },
                  );
                },
              ),
        actions: widget.highlighted == null
            ? []
            : <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.launch,
                    color: highlightColor,
                  ),
                  onPressed: () =>
                      DeviceApps.openApp(widget.highlighted.packageName),
                ),
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: highlightColor,
                  ),
                  onPressed: () => _onRename(context),
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    color: highlightColor,
                  ),
                  onPressed: () => {
                    setState(() {
                      favorites.remove(widget.highlighted).then(
                            (_) => {
                              setState(() {
                                widget.highlighted = null;
                              })
                            },
                          );
                    }),
                  },
                )
              ],
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          Observer(
            builder: (_) => AppsListWidget(
              favorites.apps,
              widget.highlighted,
              _onHighlight,
            ),
          ),
          Positioned(
            child: new Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                onPressed: () {
                  _onSettings();
                },
                icon: Icon(Icons.settings),
              ),
            ),
          ),
          Positioned(
            child: new Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: () {
                  _onSearch();
                },
                icon: Icon(Icons.search),
              ),
            ),
          )
        ],
      ),
    );
  }
}
