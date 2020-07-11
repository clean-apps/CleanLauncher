import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Use Generater Below
//> flutter packages pub run build_runner watch --delete-conflicting-outputs
//> flutter packages pub run build_runner build
part 'settings.g.dart';

class Settings = _Settings with _$Settings;

abstract class _Settings with Store {
  @observable
  bool useLightTheme = false;

  @observable
  bool useTodoList = true;

  @action
  Future<void> initStore() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    if (_prefs.containsKey("use_light_theme"))
      this.useLightTheme = _prefs.getBool("use_light_theme");

    if (_prefs.containsKey("use_todo_list"))
      this.useTodoList = _prefs.getBool("use_todo_list");
  }

  @action
  Future<void> setTheme(bool lightMode) async {
    this.useLightTheme = lightMode;

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("use_light_theme", this.useLightTheme);
  }

  @action
  Future<void> setTodoUsage(bool useTodo) async {
    this.useTodoList = useTodo;

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("use_todo_list", this.useTodoList);
  }
}
