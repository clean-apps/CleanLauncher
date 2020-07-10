import 'package:CleanLauncher/stores/settings.dart';
import 'package:CleanLauncher/stores/setup.dart';
import 'package:CleanLauncher/stores/favorites.dart';
import 'package:CleanLauncher/stores/tasklist.dart';

class StoreBuilder {
  static Settings _settings = Settings();
  static Setup _setup = Setup();
  static Favorites _favorites = Favorites();
  static TaskList _tasklist = TaskList();

  static Settings settings() {
    return _settings;
  }

  static Setup setup() {
    return _setup;
  }

  static Favorites favorites() {
    return _favorites;
  }

  static TaskList tasks() {
    return _tasklist;
  }
}
