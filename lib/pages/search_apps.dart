import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

import 'package:CleanLauncher/model/appData.dart';
import 'package:CleanLauncher/components/launcher/apps_search.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:CleanLauncher/stores/StoreBuilder.dart';
import 'package:CleanLauncher/stores/favorites.dart';

final Favorites favorites = StoreBuilder.favorites();

class SearchApps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Applications'),
        elevation: 0.0,
      ),
      body: Observer(
        builder: (_) => AppsSearchWidget(
          favorites.allApps
              .map(
                (e) => AppData(
                  appName: e.appName,
                  packageName: e.packageName,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
