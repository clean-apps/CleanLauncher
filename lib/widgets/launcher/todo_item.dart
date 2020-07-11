import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:CleanLauncher/stores/StoreBuilder.dart';
import 'package:CleanLauncher/stores/models/taskdata.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

final tasksStore = StoreBuilder.tasks();

class TodoItemWidget extends StatelessWidget {
  final TaskData task;
  final Function(BuildContext, TaskData) onEditPressed;
  final tasksStore = StoreBuilder.tasks();
  TodoItemWidget(this.task, this.onEditPressed);

  Widget _description(BuildContext context) {
    Color normalColor = Theme.of(context).textTheme.headline3.color;
    Color highlightColor = Theme.of(context).textTheme.caption.color;
    TextStyle taskDescStyle = Theme.of(context).textTheme.headline5;
    //
    return Row(
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
    );
  }

  void _onChange(bool flag) {
    task.completed = flag;
    tasksStore.save();
  }

  _swipeActions(context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    Color normalColor = _textTheme.headline3.color;
    Color highlightColor = _textTheme.caption.color;
    Color activeColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : highlightColor;

    return <Widget>[
      IconSlideAction(
        icon: Icons.edit,
        foregroundColor: normalColor,
        color: activeColor.withOpacity(0.15),
        onTap: () => onEditPressed(context, task),
      ),
      IconSlideAction(
        icon: Icons.delete,
        foregroundColor: normalColor,
        color: activeColor.withOpacity(0.25),
        onTap: () => tasksStore.remove(task.description),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Color highlightColor = Theme.of(context).textTheme.caption.color;
    Color activeColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.white;

    return Slidable(
      actionPane: SlidableScrollActionPane(),
      actionExtentRatio: 0.2,
      child: Observer(
        builder: (_) => CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: activeColor,
          checkColor: highlightColor,
          value: task.completed,
          onChanged: (flag) => _onChange(flag),
          title: _description(context),
        ),
      ),
      actions: _swipeActions(context),
      secondaryActions: _swipeActions(context),
    );
  }
}
