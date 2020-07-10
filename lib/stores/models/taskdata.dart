import 'package:mobx/mobx.dart';

// Use Generater Below
//> flutter packages pub run build_runner watch --delete-conflicting-outputs
//> flutter packages pub run build_runner build
part 'taskdata.g.dart';

class TaskData = _TaskData with _$TaskData;

abstract class _TaskData with Store {
  @observable
  String description;

  @observable
  bool completed = false;

  _TaskData(this.description, this.completed);

  @action
  toggle() {
    this.completed = !this.completed;
  }

  @action
  fromJson(json) {
    this.description = json['description'];
    this.completed = json['completed'] == 'true';
  }

  Map toJson() => {
        'description': description,
        'completed': completed ? 'true' : 'false',
      };
}
