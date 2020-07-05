import 'package:flutter/material.dart';
import 'package:CleanLauncher/model/appData.dart';
import 'package:device_apps/device_apps.dart';

class AppsListWidget extends StatelessWidget {
  //
  final List<AppData> apps;
  AppData highlighted;
  Function(AppData) _onHighlight;
  //
  AppsListWidget(this.apps, this.highlighted, this._onHighlight);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.apps.length,
      itemBuilder: (context, index) {
        AppData appData = this.apps[index];
        bool isHighlighted = highlighted != null
            ? appData.packageName == highlighted.packageName
            : false;

        Color normalColor = Theme.of(context).textTheme.headline3.color;
        Color highlightColor = Theme.of(context).textTheme.caption.color;

        return FlatButton(
          onPressed: () {
            DeviceApps.openApp(appData.packageName);
          },
          onLongPress: () {
            this._onHighlight(appData);
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              appData.appName,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: Theme.of(context).textTheme.headline3.copyWith(
                  color: isHighlighted ? highlightColor : normalColor),
            ),
          ),
        );
      },
    );
  }
}
