import 'package:mobx/mobx.dart';
import 'dart:convert';
import 'package:device_apps/device_apps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:CleanLauncher/model/appData.dart';

// Use Generater Below
//> flutter packages pub run build_runner watch --delete-conflicting-outputs
//> flutter packages pub run build_runner build
part 'favorites.g.dart';

class Favorites = _Favorites with _$Favorites;

abstract class _Favorites with Store {
  @observable
  List<AppData> apps = List();

  @observable
  List<Application> allApps = List();

  @action
  Future<void> initStore() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    this.allApps = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeSystemApps: true,
      includeAppIcons: false,
    );
    this.allApps.sort((a, b) => a.appName.compareTo(b.appName));

    if (_prefs.containsKey("favorites") &&
        _prefs.getString("favorites") != "[]") {
      //
      String jsonData = _prefs.getString("favorites");
      this.apps = List<dynamic>.from(jsonDecode(jsonData))
          .map((model) => AppData.fromJson(model))
          .toList();
    }
  }

  @action
  Future<void> save(List<AppData> pApps) async {
    String jsonSelectedApps = jsonEncode(pApps);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('favorites', jsonSelectedApps);
  }

  bool isContains(AppData pApp) {
    return this
            .apps
            .where((ele) => ele.packageName == pApp.packageName)
            .length >
        0;
  }

  bool isAllContains(AppData pApp) {
    return this
            .allApps
            .where((ele) => ele.packageName == pApp.packageName)
            .length >
        0;
  }

  @action
  Future<void> add(AppData pApp) async {
    if (pApp != null && !isContains(pApp)) {
      this.apps.add(pApp);
      await save(this.apps);
    }
  }

  @action
  Future<void> rename(AppData pApp) async {
    if (pApp != null && isContains(pApp)) {
      this
          .apps
          .where((ele) => ele.packageName == pApp.packageName)
          .first
          .appName = pApp.appName;
      //
      await save(this.apps);
    }
  }

  @action
  Future<void> remove(AppData pApp) async {
    if (pApp != null && isContains(pApp)) {
      this.apps.removeWhere(
            (ele) => ele.packageName == pApp.packageName,
          );
      //
      await save(this.apps);
    }
  }

  @computed
  int get count => this.apps.length;

  @computed
  int get count_all => this.allApps.length;

  @computed
  String get countStr =>
      this.apps.length > 0 ? this.apps.length.toString() : '';
}
