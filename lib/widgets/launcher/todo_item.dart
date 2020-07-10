import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:CleanLauncher/stores/StoreBuilder.dart';
import 'package:CleanLauncher/stores/models/taskdata.dart';

class TodoItemWidget extends StatelessWidget {
  final TaskData task;
  final tasksStore = StoreBuilder.tasks();
  TodoItemWidget(this.task);

  @override
  Widget build(BuildContext context) {
    Color normalColor = Theme.of(context).textTheme.headline3.color;
    Color highlightColor = Theme.of(context).textTheme.caption.color;
    TextStyle taskDescStyle = Theme.of(context).textTheme.headline5;
    Color activeColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.white;

    return Dismissible(
      key: Key(task.description),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        color: Colors.redAccent,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      onDismissed: (dir) => tasksStore.remove(task.description),
      child: Observer(
        builder: (_) => CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: activeColor,
          checkColor: highlightColor,
          value: task.completed,
          onChanged: (flag) => task.completed = flag,
          title: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  task.description,
                  style: taskDescStyle.copyWith(
                    color: normalColor,
                    decoration: task.completed
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: highlightColor.withOpacity(1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
