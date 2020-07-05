import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

import 'package:CleanLauncher/model/appData.dart';
import 'package:CleanLauncher/components/launcher/apps_search.dart';

class SearchApps extends StatefulWidget {
  List<AppData> apps = List();

  @override
  _SearchAppsState createState() => _SearchAppsState();
}

class _SearchAppsState extends State<SearchApps> {
  @override
  void initState() {
    super.initState();
    _getAppList();
  }

  void _getAppList() {
    DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeSystemApps: true,
      includeAppIcons: false,
    ).then((value) => {
          value.sort((a, b) => a.appName.compareTo(b.appName)),
          setState(() {
            widget.apps = value
                .map(
                  (e) => AppData(
                    appName: e.appName,
                    packageName: e.packageName,
                  ),
                )
                .toList();
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return widget.apps.length > 0
        ? Scaffold(
            appBar: AppBar(
              title: Text('Search Applications'),
              elevation: 0.0,
            ),
            body: AppsSearchWidget(widget.apps),
          )
        : Container();
  }
}
