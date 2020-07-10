// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasklist.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TaskList on _TaskList, Store {
  Computed<int> _$countComputed;

  @override
  int get count => (_$countComputed ??= Computed<int>(() => super.count)).value;

  final _$tasksAtom = Atom(name: '_TaskList.tasks');

  @override
  List<TaskData> get tasks {
    _$tasksAtom.context.enforceReadPolicy(_$tasksAtom);
    _$tasksAtom.reportObserved();
    return super.tasks;
  }

  @override
  set tasks(List<TaskData> value) {
    _$tasksAtom.context.conditionallyRunInAction(() {
      super.tasks = value;
      _$tasksAtom.reportChanged();
    }, _$tasksAtom, name: '${_$tasksAtom.name}_set');
  }

  final _$showNewTaskPanelAtom = Atom(name: '_TaskList.showNewTaskPanel');

  @override
  bool get showNewTaskPanel {
    _$showNewTaskPanelAtom.context.enforceReadPolicy(_$showNewTaskPanelAtom);
    _$showNewTaskPanelAtom.reportObserved();
    return super.showNewTaskPanel;
  }

  @override
  set showNewTaskPanel(bool value) {
    _$showNewTaskPanelAtom.context.conditionallyRunInAction(() {
      super.showNewTaskPanel = value;
      _$showNewTaskPanelAtom.reportChanged();
    }, _$showNewTaskPanelAtom, name: '${_$showNewTaskPanelAtom.name}_set');
  }

  final _$initStoreAsyncAction = AsyncAction('initStore');

  @override
  Future<void> initStore() {
    return _$initStoreAsyncAction.run(() => super.initStore());
  }

  final _$saveAsyncAction = AsyncAction('save');

  @override
  Future<void> save() {
    return _$saveAsyncAction.run(() => super.save());
  }

  final _$addAsyncAction = AsyncAction('add');

  @override
  Future<void> add(String desc) {
    return _$addAsyncAction.run(() => super.add(desc));
  }

  final _$removeAsyncAction = AsyncAction('remove');

  @override
  Future<void> remove(String desc) {
    return _$removeAsyncAction.run(() => super.remove(desc));
  }

  final _$removeCompletedAsyncAction = AsyncAction('removeCompleted');

  @override
  Future<void> removeCompleted() {
    return _$removeCompletedAsyncAction.run(() => super.removeCompleted());
  }

  final _$toggleTaskAsyncAction = AsyncAction('toggleTask');

  @override
  Future<void> toggleTask(int index) {
    return _$toggleTaskAsyncAction.run(() => super.toggleTask(index));
  }

  final _$switchItemsAsyncAction = AsyncAction('switchItems');

  @override
  Future<void> switchItems(int oldIndex, int newIndex) {
    return _$switchItemsAsyncAction
        .run(() => super.switchItems(oldIndex, newIndex));
  }

  final _$_TaskListActionController = ActionController(name: '_TaskList');

  @override
  bool contains(String name) {
    final _$actionInfo = _$_TaskListActionController.startAction();
    try {
      return super.contains(name);
    } finally {
      _$_TaskListActionController.endAction(_$actionInfo);
    }
  }

  @override
  TaskData getTask(int index) {
    final _$actionInfo = _$_TaskListActionController.startAction();
    try {
      return super.getTask(index);
    } finally {
      _$_TaskListActionController.endAction(_$actionInfo);
    }
  }

  @override
  String description(int index) {
    final _$actionInfo = _$_TaskListActionController.startAction();
    try {
      return super.description(index);
    } finally {
      _$_TaskListActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool completed(int index) {
    final _$actionInfo = _$_TaskListActionController.startAction();
    try {
      return super.completed(index);
    } finally {
      _$_TaskListActionController.endAction(_$actionInfo);
    }
  }
}
