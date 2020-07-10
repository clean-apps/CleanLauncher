import 'package:CleanLauncher/model/appData.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:CleanLauncher/stores/StoreBuilder.dart';
import 'package:CleanLauncher/stores/favorites.dart';

final Favorites favorites = StoreBuilder.favorites();

class AppsListWidget extends StatelessWidget {
  //
  void _onSettings(context) => Navigator.pushNamed(context, '/preferences');
  void _onSearch(context) => Navigator.pushNamed(context, '/search');

  TextField _getRenameField(BuildContext context) {
    Color normalColor = Theme.of(context).textTheme.headline3.color;
    OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: new BorderSide(color: normalColor),
    );
    return TextField(
      controller: TextEditingController(
        text: favorites.highlightedApp.appName,
      ),
      autofocus: true,
      onChanged: (value) => favorites.renameHighlighted(value),
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
    if (favorites.isHighlighted) {
      showDialog(
        context: context,
        child: AlertDialog(
          content: _getRenameField(context),
          actions: <Widget>[
            OutlineButton(
              borderSide: BorderSide(color: highlightColor),
              child: Text(
                "DONE",
                style: TextStyle(color: highlightColor),
              ),
              onPressed: () => favorites.rename(favorites.highlightedApp).then(
                    (_) => {
                      favorites.deselect(),
                      Navigator.of(context, rootNavigator: true).pop(),
                    },
                  ),
            )
          ],
        ),
      );
    }
  }

  _actionsHighlighted(BuildContext context) {
    Color highlightColor = Theme.of(context).textTheme.caption.color;
    return [
      IconButton(
        icon: Icon(
          Icons.launch,
          color: highlightColor,
        ),
        onPressed: () =>
            DeviceApps.openApp(favorites.highlightedApp.packageName),
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
        onPressed: () => favorites.remove(favorites.highlightedApp).then(
              (_) => favorites.deselect(),
            ),
      )
    ];
  }

  Widget _settingsButton(BuildContext context) {
    Color highlightColor = Theme.of(context).textTheme.caption.color;
    return Positioned(
      child: new Align(
        alignment: Alignment.bottomLeft,
        child: IconButton(
          onPressed: () => _onSettings(context),
          icon: Icon(Icons.settings, color: highlightColor),
        ),
      ),
    );
  }

  Widget _searchButton(BuildContext context) {
    Color highlightColor = Theme.of(context).textTheme.caption.color;
    return Positioned(
      child: new Align(
        alignment: Alignment.bottomRight,
        child: IconButton(
          onPressed: () => _onSearch(context),
          icon: Icon(Icons.search, color: highlightColor),
        ),
      ),
    );
  }

  Widget _appList(context) {
    Color normalColor = Theme.of(context).textTheme.headline3.color;
    Color highlightColor = Theme.of(context).textTheme.caption.color;

    return Observer(
      builder: (_) => ListView.builder(
        itemCount: favorites.count,
        itemBuilder: (context, index) {
          AppData appData = favorites.apps[index];
          return FlatButton(
            onPressed: () => DeviceApps.openApp(appData.packageName),
            onLongPress: () {
              favorites.highlightedIndex = index;
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                appData.appName,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.headline3.copyWith(
                    color: favorites.highlightedIndex == index
                        ? highlightColor
                        : normalColor),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color highlightColor = Theme.of(context).textTheme.caption.color;

    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          leading: favorites.isHighlighted
              ? IconButton(
                  icon: Icon(
                    Icons.chevron_left,
                    color: highlightColor,
                  ),
                  onPressed: () => favorites.deselect(),
                )
              : Container(),
          actions: favorites.isHighlighted ? _actionsHighlighted(context) : [],
          elevation: 0.0,
        ),
        body: Stack(
          children: <Widget>[
            _appList(context),
            _settingsButton(context),
            _searchButton(context)
          ],
        ),
      ),
    );
  }
}
