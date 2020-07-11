import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:CleanLauncher/stores/StoreBuilder.dart';
import 'package:CleanLauncher/widgets/launcher/apps_list.dart';
import 'package:CleanLauncher/widgets/launcher/todo_list.dart';

class Launcher extends StatelessWidget {
  final settings = StoreBuilder.settings();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        body: settings.useTodoList
            ? PageView(
                controller: PageController(initialPage: 1),
                children: <Widget>[
                  TodoListWidget(),
                  AppsListWidget(),
                ],
              )
            : AppsListWidget(),
      ),
    );
  }
}
