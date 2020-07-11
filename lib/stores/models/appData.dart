import 'package:mobx/mobx.dart';

// Use Generater Below
//> flutter packages pub run build_runner watch --delete-conflicting-outputs
//> flutter packages pub run build_runner build
part 'appdata.g.dart';

class AppData = _AppData with _$AppData;

abstract class _AppData with Store {
  @observable
  String appName;

  @observable
  String packageName;

  _AppData({this.appName, this.packageName});

  @action
  fromJson(json) {
    this.appName = json['appName'];
    this.packageName = json['packageName'];
  }

  Map toJson() => {
        'appName': appName,
        'packageName': packageName,
      };
}
