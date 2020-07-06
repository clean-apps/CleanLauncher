import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Use Generater Below
//> flutter packages pub run build_runner watch --delete-conflicting-outputs
//> flutter packages pub run build_runner build
part 'setup.g.dart';

class Setup = _Setup with _$Setup;

abstract class _Setup with Store {
  @observable
  bool isLoadingDone = false;

  @observable
  bool isSetupDone = false;

  @action
  Future<void> initStore() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    if (_prefs.containsKey("favorites") &&
        _prefs.getString("favorites") != "[]") {
      isLoadingDone = true;
      isSetupDone = true;
    } else {
      isLoadingDone = true;
      isSetupDone = false;
    }
  }
}
