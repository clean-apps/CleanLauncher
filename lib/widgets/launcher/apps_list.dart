import 'package:CleanLauncher/stores/models/appdata.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:CleanLauncher/stores/StoreBuilder.dart';
import 'package:CleanLauncher/stores/applist.dart';

final AppList appList = StoreBuilder.favorites();

class AppsListWidget extends StatelessWidget {
  //
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void _onSettings(context) => Navigator.pushNamed(context, '/preferences');
  void _onSearch(context) => Navigator.pushNamed(context, '/search');

  Widget _editTaskPanel(BuildContext context, AppData appData) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    Color inputBg = _textTheme.headline3.color.withOpacity(0.15);

    return Container(
      height: 50,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: inputBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Observer(
        builder: (_) => TextField(
          onSubmitted: (value) => {
            appList.renameHighlighted(value),
            appList.deselect(),
            onClosedPressed(context),
          },
          controller: TextEditingController(text: appData.appName),
          autofocus: true,
        ),
      ),
    );
  }

  onClosedPressed(context) {
    appList.showEditNamePanel = false;
    Navigator.pop(context);
  }

  void _onRename(BuildContext context) {
    appList.showEditNamePanel = true;
    scaffoldKey.currentState.showBottomSheet(
      (bsContext) => _editTaskPanel(bsContext, appList.highlightedApp),
    );
  }

  _actionsHighlighted(BuildContext context) {
    Color highlightColor = Theme.of(context).textTheme.caption.color;
    return [
      IconButton(
        icon: Icon(
          Icons.launch,
          color: highlightColor,
        ),
        onPressed: () => DeviceApps.openApp(appList.highlightedApp.packageName),
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
        onPressed: () => appList.remove(appList.highlightedApp).then(
              (_) => appList.deselect(),
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
        itemCount: appList.count,
        itemBuilder: (context, index) {
          AppData appData = appList.apps[index];
          return FlatButton(
            onPressed: () => DeviceApps.openApp(appData.packageName),
            onLongPress: () {
              appList.highlightedIndex = index;
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Observer(
                builder: (_) => Text(
                  appData.appName,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.headline3.copyWith(
                      color: appList.highlightedIndex == index
                          ? highlightColor
                          : normalColor),
                ),
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
        key: scaffoldKey,
        appBar: AppBar(
          leading: appList.isHighlighted
              ? IconButton(
                  icon: Icon(
                    Icons.chevron_left,
                    color: highlightColor,
                  ),
                  onPressed: () => appList.deselect(),
                )
              : Container(),
          actions: appList.isHighlighted ? _actionsHighlighted(context) : [],
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
