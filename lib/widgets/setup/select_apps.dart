import 'package:flutter/material.dart';
import 'package:CleanLauncher/stores/models/appData.dart';

class SelectAppsWidget extends StatelessWidget {
  //
  final List<AppData> allApps;
  final List<AppData> selectedApps;
  Function(AppData) onSelected;
  Function(AppData) onUnselected;
  //
  SelectAppsWidget(
    this.allApps,
    this.selectedApps,
    this.onSelected,
    this.onUnselected,
  );

  @override
  Widget build(BuildContext context) {
    var selectedTheme = Theme.of(context)
        .textTheme
        .headline3
        .copyWith(color: Theme.of(context).textTheme.caption.color);
    var normalTheme = Theme.of(context).textTheme.headline3;

    return ListView.builder(
      itemCount: this.allApps.length,
      itemBuilder: (context, index) {
        AppData appData = this.allApps[index];
        bool isSelected = this
                .selectedApps
                .where((element) => element.packageName == appData.packageName)
                .length >
            0;
        return FlatButton(
          onPressed: () {
            isSelected ? onUnselected(appData) : onSelected(appData);
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              appData.appName,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: isSelected ? selectedTheme : normalTheme,
            ),
          ),
        );
      },
    );
  }
}
