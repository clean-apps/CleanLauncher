import 'package:CleanLauncher/stores/StoreBuilder.dart';
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
    Color inputBg =
        Theme.of(context).textTheme.headline3.color.withOpacity(0.15);

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

  onAddPressed(context) {
    tasksStore.showNewTaskPanel = true;
    _bsController = scaffoldKey.currentState.showBottomSheet(
      (bsContext) => _newTaskPanel(bsContext),
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
    TextTheme _textTheme = Theme.of(context).textTheme;
    Color normalColor = _textTheme.headline3.color;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _title(context),
        actions: <Widget>[_actionRemoveComp(context)],
        elevation: 0.0,
      ),
      body: Observer(
        builder: (_) => ListView.separated(
          itemCount: tasksStore.count,
          itemBuilder: (_, index) => TodoItemWidget(
            tasksStore.getTask(index),
          ),
          separatorBuilder: (_, index) => Divider(
            color: normalColor.withOpacity(0.5),
          ),
        ),
      ),
      floatingActionButton: _fab(context),
    );
  }
}
