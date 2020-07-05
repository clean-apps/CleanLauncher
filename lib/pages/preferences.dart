import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:CleanLauncher/pages/setup_fav_apps.dart';

class Preferences extends StatelessWidget {
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
            value: true,
            onChanged: (val) {},
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
