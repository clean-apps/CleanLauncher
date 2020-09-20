import 'package:android_intent/android_intent.dart';
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
    // ignore: non_constant_identifier_names
    final int FLAGACTIVITYNEWTASK = 268435456;
    AndroidIntent launcherIntent = AndroidIntent(
      action: 'android.intent.action.MAIN',
      category: 'android.intent.category.HOME',
      flags: [FLAGACTIVITYNEWTASK],
    );

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
          ListTile(
            title: Text('Reorder Favorites'),
            onTap: () => Navigator.pushNamed(context, '/reorder'),
          ),
          Observer(
            builder: (_) => SwitchListTile(
              title: Text('Use Dark Theme'),
              value: !settings.useLightTheme,
              onChanged: (lightMode) => settings.setTheme(lightMode),
            ),
          ),
          Observer(
            builder: (_) => SwitchListTile(
              title: Text('Use TODO List'),
              value: settings.useTodoList,
              onChanged: (useTodo) => settings.setTodoUsage(useTodo),
            ),
          ),
          ListTile(
            title: Text('Reset All Data'),
            onTap: () async => {
              await applist.reset(),
              await tasklist.reset(),
              Navigator.pushNamed(context, '/favorites'),
            },
          ),
          ListTile(
            title: Text('Select Launcher'),
            onTap: () async => {
              await launcherIntent.launch(),
            },
          )
        ],
      ),
    );
  }
}
