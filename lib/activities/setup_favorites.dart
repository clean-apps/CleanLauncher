import 'package:flutter/material.dart';
import 'package:CleanLauncher/stores/models/appData.dart';
import 'package:CleanLauncher/widgets/setup/select_apps.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:CleanLauncher/stores/StoreBuilder.dart';
import 'package:CleanLauncher/stores/applist.dart';

final AppList appList = StoreBuilder.favorites();

class SetupFavorites extends StatefulWidget {
  int selected = 0;
  @override
  _SetupFavoritesState createState() => _SetupFavoritesState();
}

class _SetupFavoritesState extends State<SetupFavorites> {
  selectApplication(AppData selected) {
    appList.add(selected).then((_) => setState(() => widget.selected++));
  }

  unselectApplication(AppData unselected) {
    appList.remove(unselected).then((_) => setState(
          () => widget.selected--,
        ));
  }

  doNext() {
    Navigator.pushNamed(context, '/launcher');
  }

  @override
  Widget build(BuildContext context) {
    Color highlightColor = Theme.of(context).textTheme.caption.color;
    TextStyle appTitleStyle = Theme.of(context).textTheme.headline5;
    TextStyle appActionStyle = Theme.of(context)
        .textTheme
        .headline4
        .copyWith(color: Theme.of(context).textTheme.caption.color);

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Favorite Apps', style: appTitleStyle),
        actions: <Widget>[Text(appList.countStr, style: appActionStyle)],
        automaticallyImplyLeading: false,
        elevation: 0.0,
      ),
      body: Observer(
        builder: (_) => SelectAppsWidget(
          appList.allApps,
          appList.apps,
          selectApplication,
          unselectApplication,
        ),
      ),
      floatingActionButton: appList.count > 0
          ? FloatingActionButton.extended(
              onPressed: () => doNext(),
              label: Text('NEXT', style: TextStyle(color: highlightColor)),
              icon: Icon(Icons.keyboard_arrow_right, color: highlightColor),
            )
          : Container(),
    );
  }
}
