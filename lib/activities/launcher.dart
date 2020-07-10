import 'package:flutter/material.dart';
import 'package:CleanLauncher/widgets/launcher/apps_list.dart';
import 'package:CleanLauncher/widgets/launcher/todo_list.dart';

class Launcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: PageController(initialPage: 1),
        children: <Widget>[
          TodoListWidget(),
          AppsListWidget(),
        ],
      ),
    );
  }
}
