import 'package:mobx/mobx.dart';
import 'dart:convert';
import 'package:device_apps/device_apps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:CleanLauncher/stores/models/appdata.dart';

// Use Generater Below
//> flutter packages pub run build_runner watch --delete-conflicting-outputs
//> flutter packages pub run build_runner build
part 'applist.g.dart';

class AppList = _AppList with _$AppList;

abstract class _AppList with Store {
  @observable
  List<AppData> apps = ObservableList();

  @observable
  List<AppData> allApps = ObservableList();

  @observable
  int highlightedIndex = -1;

  @observable
  bool isLoadingDone = false;

  @observable
  bool isSetupDone = false;

  @observable
  bool showEditNamePanel = false;

  @action
  Future<void> initStore() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    List<Application> deviceApps = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeSystemApps: true,
      includeAppIcons: false,
    );

    this.allApps.clear();
    this.allApps.addAll(
          deviceApps
              .map(
                (app) => AppData(
                  appName: app.appName,
                  packageName: app.packageName,
                ),
              )
              .toList(),
        );

    this.allApps.sort((a, b) => a.appName.compareTo(b.appName));

    if (_prefs.containsKey("favorites") &&
        _prefs.getString("favorites") != "[]") {
      //
      String jsonData = _prefs.getString("favorites");
      this.apps.clear();
      this.apps.addAll(
            List<dynamic>.from(jsonDecode(jsonData))
                .map(
                  (json) => AppData(
                    appName: json['appName'],
                    packageName: json['packageName'],
                  ),
                )
                .toList(),
          );

      //
      isLoadingDone = true;
      isSetupDone = true;
      //
    } else {
      //
      isLoadingDone = true;
      isSetupDone = false;
      //
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
  void select(int index) {
    if (index <= this.apps.length) {
      this.highlightedIndex = index;
    }
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

  @action
  Future<void> renameHighlighted(String newName) async {
    if (newName != null) {
      highlightedApp.appName = newName;
      await save(this.apps);
    }
  }

  @action
  void deselect() {
    this.highlightedIndex = -1;
  }

  @action
  Future<void> switchItems(int oldIndex, int newIndex) async {
    AppData item1 = this.apps[oldIndex];
    AppData item2 = this.apps[newIndex];
    this.apps[oldIndex] = item2;
    this.apps[newIndex] = item1;
    await save(this.apps);
  }

  @action
  Future<void> reset() async {
    this.apps.clear();
    await this.save(this.apps);
  }

  @computed
  int get count => this.apps.length;

  @computed
  String get countStr => this.count > 0 ? this.count.toString() : '';

  @computed
  bool get isHighlighted => highlightedIndex >= 0;

  @computed
  AppData get highlightedApp => this.apps[highlightedIndex];
}
