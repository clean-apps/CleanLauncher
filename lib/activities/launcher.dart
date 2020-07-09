import 'package:flutter/material.dart';
import 'package:CleanLauncher/activities/launcher_apps.dart';
import 'package:CleanLauncher/activities/launcher_todos.dart';

class Launcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      controller: PageController(
        initialPage: 1,
      ),
      children: <Widget>[
        LauncherTodos(),
        LauncherApps(),
      ],
    ));
  }
}
