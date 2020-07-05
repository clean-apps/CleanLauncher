import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:CleanLauncher/model/appData.dart';
import 'package:CleanLauncher/components/setup/select_apps.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:CleanLauncher/pages/launcher_app_list.dart';

class SetupFavApps extends StatefulWidget {
  List<AppData> selectedApps = new List();
  Future<List<Application>> allApps;

  @override
  _SetupFavAppsState createState() => _SetupFavAppsState();
}

class _SetupFavAppsState extends State<SetupFavApps> {
  @override
  void initState() {
    super.initState();
    widget.allApps = _getAppList();
    SharedPreferences.getInstance().then(
      (prefs) => {
        if (prefs != null && prefs.containsKey("favorites"))
          {
            _decodeFavorites(prefs.getString("favorites")),
          }
      },
    );
  }

  void _decodeFavorites(String jsonData) {
    setState(() {
      widget.selectedApps = List<dynamic>.from(jsonDecode(jsonData))
          .map(
            (model) => AppData.fromJson(model),
          )
          .toList();
    });
  }

  Future<List<Application>> _getAppList() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeSystemApps: true,
      includeAppIcons: false,
    );
    return apps;
  }

  selectApplication(Application selected) {
    setState(() {
      widget.selectedApps.add(AppData(
        appName: selected.appName,
        packageName: selected.packageName,
      ));
    });
  }

  unselectApplication(Application unselected) {
    setState(() {
      widget.selectedApps.removeWhere(
        (ele) => ele.packageName == unselected.packageName,
      );
    });
  }

  doNext() async {
    String jsonSelectedApps = jsonEncode(widget.selectedApps);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('favorites', jsonSelectedApps);
    //
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LauncherAppList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var hasSelected = widget.selectedApps.length > 0;
    var selectedCount = widget.selectedApps.length.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Favorite Apps',
          style: Theme.of(context).textTheme.headline5,
        ),
        actions: hasSelected
            ? <Widget>[
                Text(
                  selectedCount,
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Theme.of(context).textTheme.caption.color,
                      ),
                )
              ]
            : [],
        automaticallyImplyLeading: false,
        elevation: 0.0,
      ),
      body: SelectAppsWidget(
        widget.allApps,
        widget.selectedApps,
        selectApplication,
        unselectApplication,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          doNext();
        },
        label: Text('NEXT'),
        icon: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
