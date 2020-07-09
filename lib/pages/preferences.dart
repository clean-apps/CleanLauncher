import 'package:flutter/material.dart';

import 'package:CleanLauncher/pages/setup_favorites.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:CleanLauncher/stores/StoreBuilder.dart';
import 'package:CleanLauncher/stores/settings.dart';

final Settings settings = StoreBuilder.settings();

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
            onTap: () => Navigator.pushNamed(context, '/favorites'),
          ),
          Observer(
            builder: (_) => SwitchListTile(
              title: Text('Use Light Theme'),
              value: settings.useLightTheme,
              onChanged: (lightMode) => settings.setTheme(lightMode),
            ),
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
