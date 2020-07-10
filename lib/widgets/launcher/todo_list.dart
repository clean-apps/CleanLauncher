import 'package:CleanLauncher/stores/StoreBuilder.dart';
import 'package:CleanLauncher/stores/models/taskdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

final tasksStore = StoreBuilder.tasks();

class TodoListWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  onAddPressed(scaffoldKey, icontext) {
    Color inputBg =
        Theme.of(icontext).textTheme.headline3.color.withOpacity(0.15);
    //
    tasksStore.showAddTaskPanel(true);
    scaffoldKey.currentState.showBottomSheet(
      (context) => Container(
        height: 50,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: inputBg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Observer(
          builder: (_) => TextField(
            onSubmitted: (value) => {
              tasksStore.add(value),
              onClosedPressed(context),
            },
            decoration: InputDecoration.collapsed(
              hintText: 'New Task',
            ),
            autofocus: true,
          ),
        ),
      ),
    );
  }

  onClosedPressed(context) {
    tasksStore.showAddTaskPanel(false);
    Navigator.of(context).pop();
  }

  Widget _getTaskTile(BuildContext context, TaskData thisTask) {
    Color normalColor = Theme.of(context).textTheme.headline3.color;
    Color highlightColor = Theme.of(context).textTheme.caption.color;
    TextStyle taskDescStyle = Theme.of(context).textTheme.headline5;
    Color activeColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : Colors.white;

    return Dismissible(
      key: Key(thisTask.description),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        color: Colors.redAccent,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      onDismissed: (dir) => tasksStore.remove(thisTask.description),
      child: Observer(
        builder: (_) => CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: activeColor,
          checkColor: highlightColor,
          value: thisTask.completed,
          onChanged: (flag) => thisTask.completed = flag,
          title: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  thisTask.description,
                  overflow: TextOverflow.ellipsis,
                  style: taskDescStyle.copyWith(
                    color: normalColor,
                    decoration: thisTask.completed
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

  Observer _getFAB(BuildContext context) {
    Color highlightColor = Theme.of(context).textTheme.caption.color;

    return Observer(
      builder: (_) => FloatingActionButton.extended(
        onPressed: () => tasksStore.addTaskShown
            ? onClosedPressed(context)
            : onAddPressed(scaffoldKey, context),
        label: Text(
          tasksStore.addTaskShown ? 'CLOSE' : 'NEW',
          style: TextStyle(color: highlightColor),
        ),
        icon: tasksStore.addTaskShown
            ? Icon(Icons.close, color: highlightColor)
            : Icon(Icons.add, color: highlightColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    Color normalColor = _textTheme.headline3.color;
    Color highlightColor = _textTheme.caption.color;
    TextStyle lightStyle = TextStyle(
      color: _textTheme.headline3.color.withOpacity(0.5),
    );

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            Text('TASKS '),
            Observer(
              builder: (_) => Text(
                tasksStore.count.toString(),
                style: lightStyle,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear_all, color: highlightColor),
            onPressed: tasksStore.removeCompleted,
          )
        ],
        elevation: 0.0,
      ),
      body: Observer(
        builder: (_) => ListView.separated(
          itemCount: tasksStore.count,
          itemBuilder: (_, index) {
            final thisTask = tasksStore.getTask(index);
            return this._getTaskTile(context, thisTask);
          },
          separatorBuilder: (_, index) => Divider(
            color: normalColor.withOpacity(0.5),
          ),
        ),
      ),
      floatingActionButton: _getFAB(context),
    );
  }
}
