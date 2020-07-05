import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:CleanLauncher/model/appData.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:CleanLauncher/pages/preferences.dart';
import 'package:CleanLauncher/pages/search_apps.dart';
import 'package:CleanLauncher/components/apps_list.dart';

class LauncherAppList extends StatefulWidget {
  List<AppData> selectedApps = new List();

  @override
  _LauncherAppListState createState() => _LauncherAppListState();
}

class _LauncherAppListState extends State<LauncherAppList> {
  void _decodeFavorites(String jsonData) {
    setState(() {
      widget.selectedApps = List<dynamic>.from(jsonDecode(jsonData))
          .map(
            (model) => AppData.fromJson(model),
          )
          .toList();
    });
  }

  void _onSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Preferences()),
    );
  }

  void _onSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchApps()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedApps.length == 0) {
      SharedPreferences.getInstance().then(
        (prefs) => _decodeFavorites(prefs.getString("favorites")),
      );
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppsListWidget(widget.selectedApps),
          Positioned(
            child: new Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                onPressed: () {
                  _onSettings();
                },
                icon: Icon(Icons.settings),
              ),
            ),
          ),
          Positioned(
            child: new Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: () {
                  _onSearch();
                },
                icon: Icon(Icons.search),
              ),
            ),
          )
        ],
      ),
    );
  }
}
