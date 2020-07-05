import 'package:flutter/material.dart';
import 'package:CleanLauncher/model/appData.dart';
import 'package:device_apps/device_apps.dart';

class AppsListWidget extends StatelessWidget {
  //
  final List<AppData> apps;
  //
  AppsListWidget(
    this.apps,
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.apps.length,
      itemBuilder: (context, index) {
        AppData appData = this.apps[index];

        return FlatButton(
          onPressed: () {
            DeviceApps.openApp(appData.packageName);
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              appData.appName,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        );
      },
    );
  }
}
