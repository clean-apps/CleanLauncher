import 'package:CleanLauncher/stores/StoreBuilder.dart';
import 'package:CleanLauncher/stores/models/taskdata.dart';
import 'package:CleanLauncher/widgets/launcher/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

final tasksStore = StoreBuilder.tasks();

class TodoListWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController _bsController;

  Widget _title(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    TextStyle lightStyle = TextStyle(
      color: _textTheme.headline3.color.withOpacity(0.5),
    );
    return Row(
      children: <Widget>[
        Text('TASKS '),
        Observer(
          builder: (_) => Text(
            tasksStore.count.toString(),
            style: lightStyle,
          ),
        ),
      ],
    );
  }

  Widget _actionRemoveComp(BuildContext context) {
    Color highlightColor = Theme.of(context).textTheme.caption.color;

    return IconButton(
      icon: Icon(Icons.clear_all, color: highlightColor),
      onPressed: tasksStore.removeCompleted,
    );
  }

  Widget _newTaskPanel(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    Color inputBg = _textTheme.headline3.color.withOpacity(0.15);

    return Container(
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
          decoration: InputDecoration.collapsed(hintText: 'New Task'),
          autofocus: true,
        ),
      ),
    );
  }

  Widget _editTaskPanel(BuildContext context, TaskData task) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    Color inputBg = _textTheme.headline3.color.withOpacity(0.15);

    return Container(
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
            tasksStore.edit(task.description, value),
            onClosedPressed(context),
          },
          controller: TextEditingController(text: task.description),
          autofocus: true,
        ),
      ),
    );
  }

  onAddPressed(context) {
    tasksStore.showNewTaskPanel = true;
    _bsController = scaffoldKey.currentState.showBottomSheet(
      (bsContext) => _newTaskPanel(bsContext),
    );
  }

  onEditPressed(BuildContext context, TaskData task) {
    tasksStore.showNewTaskPanel = true;
    _bsController = scaffoldKey.currentState.showBottomSheet(
      (bsContext) => _editTaskPanel(bsContext, task),
    );
  }

  onClosedPressed(context) {
    tasksStore.showNewTaskPanel = false;
    if (_bsController != null)
      _bsController.close();
    else
      Navigator.pop(context);
  }

  Observer _fab(BuildContext context) {
    Color highlightColor = Theme.of(context).textTheme.caption.color;

    return Observer(
      builder: (_) => FloatingActionButton.extended(
        onPressed: () => tasksStore.showNewTaskPanel
            ? onClosedPressed(context)
            : onAddPressed(context),
        label: Text(
          tasksStore.showNewTaskPanel ? 'CLOSE' : 'NEW',
          style: TextStyle(color: highlightColor),
        ),
        icon: tasksStore.showNewTaskPanel
            ? Icon(Icons.close, color: highlightColor)
            : Icon(Icons.add, color: highlightColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _title(context),
        actions: <Widget>[_actionRemoveComp(context)],
        elevation: 0.0,
      ),
      body: Observer(
        builder: (_) => ReorderableListView(
          onReorder: (oldIdx, newIdx) => tasksStore.switchItems(oldIdx, newIdx),
          children: <Widget>[
            for (TaskData task in tasksStore.tasks)
              ListTile(
                key: Key(task.description),
                title: TodoItemWidget(task, onEditPressed),
              )
          ],
        ),
      ),
      floatingActionButton: _fab(context),
    );
  }
}
