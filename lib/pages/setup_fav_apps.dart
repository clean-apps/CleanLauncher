import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:CleanLauncher/model/appData.dart';
import 'package:CleanLauncher/components/setup/select_apps.dart';

import 'package:CleanLauncher/pages/launcher_app_list.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:CleanLauncher/stores/StoreBuilder.dart';
import 'package:CleanLauncher/stores/favorites.dart';

final Favorites favorites = StoreBuilder.favorites();

class SetupFavApps extends StatefulWidget {
  int selected = 0;
  @override
  _SetupFavAppsState createState() => _SetupFavAppsState();
}

class _SetupFavAppsState extends State<SetupFavApps> {
  selectApplication(Application selected) {
    favorites
        .add(AppData(
          appName: selected.appName,
          packageName: selected.packageName,
        ))
        .then((_) => setState(() => widget.selected++));
  }

  unselectApplication(Application unselected) {
    favorites
        .remove(AppData(
          appName: unselected.appName,
          packageName: unselected.packageName,
        ))
        .then((_) => setState(
              () => widget.selected--,
            ));
  }

  doNext() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LauncherAppList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle appTitleStyle = Theme.of(context).textTheme.headline5;
    TextStyle appActionStyle = Theme.of(context)
        .textTheme
        .headline4
        .copyWith(color: Theme.of(context).textTheme.caption.color);

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Favorite Apps', style: appTitleStyle),
        actions: <Widget>[
          Text(
            favorites.apps.length > 0 ? favorites.apps.length.toString() : '',
            style: appActionStyle,
          )
        ],
        automaticallyImplyLeading: false,
        elevation: 0.0,
      ),
      body: Observer(
        builder: (_) => SelectAppsWidget(
          favorites.allApps,
          favorites.apps,
          selectApplication,
          unselectApplication,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => doNext(),
        label: Text('NEXT'),
        icon: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
