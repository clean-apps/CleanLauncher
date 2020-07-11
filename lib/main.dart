import 'package:flutter/material.dart';
import 'package:CleanLauncher/styles/AppThemes.dart';

import 'package:CleanLauncher/activities/setup_welcome.dart';
import 'package:CleanLauncher/activities/launcher.dart';
import 'package:CleanLauncher/activities/preferences.dart';
import 'package:CleanLauncher/activities/search_apps.dart';
import 'package:CleanLauncher/activities/setup_favorites.dart';
import 'package:CleanLauncher/activities/reorder_favorites.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:CleanLauncher/stores/StoreBuilder.dart';
import 'package:CleanLauncher/stores/settings.dart';
import 'package:CleanLauncher/stores/applist.dart';
import 'package:CleanLauncher/stores/tasklist.dart';

final Settings settings = StoreBuilder.settings();
final AppList appList = StoreBuilder.favorites();
final TaskList tasks = StoreBuilder.tasks();

void main() {
  runApp(LauncherApp());
}

class LauncherApp extends StatefulWidget {
  //
  @override
  _LauncherAppState createState() => _LauncherAppState();
}

class _LauncherAppState extends State<LauncherApp> {
  @override
  void initState() {
    super.initState();
    settings.initStore();
    appList.initStore();
    tasks.initStore();
  }

  Widget _getHomeWidget() {
    return appList.isLoadingDone
        ? (appList.isSetupDone ? Launcher() : SetupWelcome())
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        theme: settings.useLightTheme ? lightTheme : darkTheme,
        home: _getHomeWidget(),
        routes: {
          "/launcher": (context) => Launcher(),
          "/setup": (context) => SetupWelcome(),
          "/favorites": (context) => SetupFavorites(),
          "/preferences": (context) => Preferences(),
          "/reorder": (context) => ReorderFavorites(),
          "/search": (context) => SearchApps(),
        },
      ),
    );
  }
}
