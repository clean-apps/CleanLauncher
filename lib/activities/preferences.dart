import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:CleanLauncher/stores/StoreBuilder.dart';
import 'package:CleanLauncher/stores/settings.dart';

import 'package:CleanLauncher/stores/applist.dart';
import 'package:CleanLauncher/stores/tasklist.dart';

final Settings settings = StoreBuilder.settings();
final AppList applist = StoreBuilder.favorites();
final TaskList tasklist = StoreBuilder.tasks();

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
            title: Text('Reset'),
            onTap: () async => {
              await applist.reset(),
              await tasklist.reset(),
              Navigator.pushNamed(context, '/favorites'),
            },
          ),
          ListTile(
            title: Text('Select Another Launcher'),
          )
        ],
      ),
    );
  }
}
