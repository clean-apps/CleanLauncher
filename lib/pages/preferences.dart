import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:CleanLauncher/pages/setup_fav_apps.dart';

class Preferences extends StatefulWidget {
  @override
  _PreferencesState createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  void _useLightTheme() {
    setState(() {
      SharedPreferences.getInstance().then(
        (prefs) => prefs.setBool("use_light_theme", true),
      );
    });
  }

  void _useDarkTheme() {
    setState(() {
      SharedPreferences.getInstance().then(
        (prefs) => prefs.setBool("use_light_theme", false),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferences'),
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Select Favorite Apps'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SetupFavApps()),
              );
            },
          ),
          SwitchListTile(
            title: Text('Use Dark Theme'),
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: (val) {
              if (val) {
                _useDarkTheme();
              } else {
                _useLightTheme();
              }
            },
          ),
          SwitchListTile(
            title: Text('Use TODO List'),
            value: false,
            onChanged: (val) {},
          ),
          ListTile(
            title: Text('Select Another Launcher'),
          )
        ],
      ),
    );
  }
}
