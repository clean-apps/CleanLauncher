import 'package:flutter/material.dart';
import 'package:CleanLauncher/styles/AppThemes.dart';

import 'package:CleanLauncher/pages/setup_welcome.dart';
import 'package:CleanLauncher/pages/launcher_apps.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:CleanLauncher/stores/StoreBuilder.dart';
import 'package:CleanLauncher/stores/settings.dart';
import 'package:CleanLauncher/stores/setup.dart';
import 'package:CleanLauncher/stores/favorites.dart';

final Settings settings = StoreBuilder.settings();
final Setup setup = StoreBuilder.setup();
final Favorites favorites = StoreBuilder.favorites();

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
    setup.initStore();
    favorites.initStore();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        theme: settings.useLightTheme ? lightTheme : darkTheme,
        home: setup.isLoadingDone
            ? (setup.isSetupDone ? LauncherApps() : SetupWelcome())
            : Container(),
      ),
    );
  }
}
