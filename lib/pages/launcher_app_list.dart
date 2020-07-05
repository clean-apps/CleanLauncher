import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:CleanLauncher/model/appData.dart';
import 'package:device_apps/device_apps.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:CleanLauncher/pages/preferences.dart';
import 'package:CleanLauncher/pages/search_apps.dart';
import 'package:CleanLauncher/components/launcher/apps_list.dart';

class LauncherAppList extends StatefulWidget {
  List<AppData> selectedApps = new List();
  AppData highlighted = null;

  @override
  _LauncherAppListState createState() => _LauncherAppListState();
}

class _LauncherAppListState extends State<LauncherAppList> {
  void _decodeFavorites(String jsonData) {
    setState(() {
      widget.selectedApps = List<dynamic>.from(jsonDecode(jsonData))
          .map(
            (model) => AppData.fromJson(model),
          )
          .toList();
    });
  }

  void _onSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Preferences()),
    );
  }

  void _onSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchApps()),
    );
  }

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
                onPressed: () {
                  setState(() {
                    widget.selectedApps
                        .where(
                          (ele) =>
                              ele.packageName == widget.highlighted.packageName,
                        )
                        .first
                        .appName = widget.highlighted.appName;
                    //
                    String jsonSelectedApps = jsonEncode(widget.selectedApps);
                    SharedPreferences.getInstance().then(
                      (prefs) => {
                        prefs.setString('favorites', jsonSelectedApps),
                        widget.highlighted = null
                      },
                    );
                    //
                    widget.highlighted = null;
                    Navigator.of(context, rootNavigator: true).pop();
                  });
                })
          ],
        ),
      );
    }
  }

  void _onRemoveApp() {
    if (widget.highlighted != null) {
      setState(() {
        widget.selectedApps.removeWhere(
          (element) => element.packageName == widget.highlighted.packageName,
        );
        //
        String jsonSelectedApps = jsonEncode(widget.selectedApps);
        SharedPreferences.getInstance().then(
          (prefs) => {
            prefs.setString('favorites', jsonSelectedApps),
            widget.highlighted = null
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color highlightColor = Theme.of(context).textTheme.caption.color;
    if (widget.selectedApps.length == 0) {
      SharedPreferences.getInstance().then(
        (prefs) => _decodeFavorites(prefs.getString("favorites")),
      );
    }

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
                  onPressed: () {
                    DeviceApps.openApp(widget.highlighted.packageName);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: highlightColor,
                  ),
                  onPressed: () {
                    _onRename(context);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    color: highlightColor,
                  ),
                  onPressed: () {
                    _onRemoveApp();
                  },
                )
              ],
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          AppsListWidget(widget.selectedApps, widget.highlighted, _onHighlight),
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
