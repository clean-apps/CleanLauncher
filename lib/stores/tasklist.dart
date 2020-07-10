import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'dart:convert';
import 'package:CleanLauncher/stores/models/taskdata.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Use Generater Below
//> flutter packages pub run build_runner watch --delete-conflicting-outputs
//> flutter packages pub run build_runner build
part 'tasklist.g.dart';

class TaskList = _TaskList with _$TaskList;

abstract class _TaskList with Store {
  @observable
  List<TaskData> tasks = ObservableList();

  @observable
  bool addTaskShown = false;

  @action
  Future<void> initStore() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    if (_prefs.containsKey("tasks") && _prefs.getString("tasks") != "[]") {
      //
      String jsonData = _prefs.getString("tasks");
      this.tasks.clear();
      this.tasks.addAll(
            List<dynamic>.from(jsonDecode(jsonData))
                .map(
                  (json) => TaskData(
                    json['description'],
                    json['completed'] == 'true',
                  ),
                )
                .toList(),
          );
    }

    //reaction((_) => tasks, (tasks) => save());
  }

  @action
  void showAddTaskPanel(bool isShown) {
    this.addTaskShown = isShown;
  }

  @action
  Future<void> save() async {
    String jsonTasks = jsonEncode(this.tasks);
    debugPrint(jsonTasks);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return await _prefs.setString('tasks', jsonTasks);
  }

  @action
  bool contains(String name) {
    return name != null &&
        this.tasks.where((ele) => ele.description == name).length > 0;
  }

  @computed
  int get count => this.tasks.length;

  @action
  TaskData getTask(int index) {
    return this.tasks[index];
  }

  @action
  String description(int index) {
    return getTask(index).description;
  }

  @action
  bool completed(int index) {
    return getTask(index).completed;
  }

  @action
  Future<void> add(String desc) async {
    if (!contains(desc)) {
      this.tasks.add(
            TaskData(desc, false),
          );
      await save();
    }
  }

  @action
  Future<void> remove(String desc) async {
    if (contains(desc)) {
      this.tasks.removeWhere((ele) => ele.description == desc);
      await save();
    }
  }

  @action
  Future<void> removeCompleted() async {
    this.tasks.removeWhere((ele) => ele.completed);
    await save();
  }

  @action
  Future<void> toggleTask(int index) async {
    this.tasks[index].toggle();
    await save();
  }
}
