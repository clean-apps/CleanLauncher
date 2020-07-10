import 'package:CleanLauncher/stores/settings.dart';
import 'package:CleanLauncher/stores/applist.dart';
import 'package:CleanLauncher/stores/tasklist.dart';

class StoreBuilder {
  static Settings _settings = Settings();
  static AppList _appList = AppList();
  static TaskList _tasklist = TaskList();

  static Settings settings() {
    return _settings;
  }

  static AppList favorites() {
    return _appList;
  }

  static TaskList tasks() {
    return _tasklist;
  }
}
