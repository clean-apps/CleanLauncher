class AppData {
  String appName;
  String packageName;

  AppData({this.appName, this.packageName});

  static AppData fromJson(json) {
    AppData appData = new AppData();
    appData.appName = json['appName'];
    appData.packageName = json['packageName'];
    return appData;
  }

  Map toJson() => {
        'appName': appName,
        'packageName': packageName,
      };
}
