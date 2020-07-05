import 'package:flutter/material.dart';
import 'package:CleanLauncher/styles/AppThemes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:CleanLauncher/pages/setup_welcome.dart';
import 'package:CleanLauncher/pages/launcher_app_list.dart';

void main() {
  runApp(LauncherApp());
}

class LauncherApp extends StatefulWidget {
  bool isLoadingDone = false;
  bool isSetupDone = false;
  SharedPreferences prefs;
  //
  @override
  _LauncherAppState createState() => _LauncherAppState();
}

class _LauncherAppState extends State<LauncherApp> {
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then(
      (prefs) => {
        widget.prefs = prefs,
        _init(),
      },
    );
  }

  void _init() {
    if (widget.prefs.containsKey("favorites") &&
        widget.prefs.getString("favorites") != "[]") {
      setState(() => {
            widget.isLoadingDone = true,
            widget.isSetupDone = true,
          });
    } else {
      setState(() => {
            widget.isLoadingDone = true,
            widget.isSetupDone = false,
          });
    }
  }

  bool _useLightTheme() {
    return widget.prefs != null &&
        widget.prefs.containsKey("use_light_theme") &&
        widget.prefs.getBool("use_light_theme");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _useLightTheme() ? lightTheme : darkTheme,
      home: widget.isLoadingDone
          ? (widget.isSetupDone ? LauncherAppList() : SetupWelcome())
          : Container(),
    );
  }
}
