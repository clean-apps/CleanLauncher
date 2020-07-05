import 'package:flutter/material.dart';
import 'package:CleanLauncher/styles/DarkTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:CleanLauncher/pages/setup_welcome.dart';
import 'package:CleanLauncher/pages/launcher_app_list.dart';

void main() {
  runApp(LauncherApp());
}

class LauncherApp extends StatefulWidget {
  bool isLoadingDone = false;
  bool isSetupDone = false;
  @override
  _LauncherAppState createState() => _LauncherAppState();
}

class _LauncherAppState extends State<LauncherApp> {
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then(
      (prefs) => {
        if (prefs.containsKey("favorites") &&
            prefs.getString("favorites") != "[]")
          setState(() => {
                widget.isLoadingDone = true,
                widget.isSetupDone = true,
              })
        else
          setState(() => {
                widget.isLoadingDone = true,
                widget.isSetupDone = false,
              })
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme,
      home: widget.isLoadingDone
          ? (widget.isSetupDone ? LauncherAppList() : SetupWelcome())
          : Container(),
    );
  }
}
