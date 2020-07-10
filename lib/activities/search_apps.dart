import 'package:flutter/material.dart';

import 'package:CleanLauncher/widgets/launcher/apps_search.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:CleanLauncher/stores/StoreBuilder.dart';
import 'package:CleanLauncher/stores/applist.dart';

final AppList appList = StoreBuilder.favorites();

class SearchApps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Applications'),
        elevation: 0.0,
      ),
      body: Observer(
        builder: (_) => AppsSearchWidget(appList.allApps),
      ),
    );
  }
}
