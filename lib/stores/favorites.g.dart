// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Favorites on _Favorites, Store {
  Computed<int> _$countComputed;

  @override
  int get count => (_$countComputed ??= Computed<int>(() => super.count)).value;
  Computed<int> _$count_allComputed;

  @override
  int get count_all =>
      (_$count_allComputed ??= Computed<int>(() => super.count_all)).value;
  Computed<String> _$countStrComputed;

  @override
  String get countStr =>
      (_$countStrComputed ??= Computed<String>(() => super.countStr)).value;

  final _$appsAtom = Atom(name: '_Favorites.apps');

  @override
  List<AppData> get apps {
    _$appsAtom.context.enforceReadPolicy(_$appsAtom);
    _$appsAtom.reportObserved();
    return super.apps;
  }

  @override
  set apps(List<AppData> value) {
    _$appsAtom.context.conditionallyRunInAction(() {
      super.apps = value;
      _$appsAtom.reportChanged();
    }, _$appsAtom, name: '${_$appsAtom.name}_set');
  }

  final _$allAppsAtom = Atom(name: '_Favorites.allApps');

  @override
  List<Application> get allApps {
    _$allAppsAtom.context.enforceReadPolicy(_$allAppsAtom);
    _$allAppsAtom.reportObserved();
    return super.allApps;
  }

  @override
  set allApps(List<Application> value) {
    _$allAppsAtom.context.conditionallyRunInAction(() {
      super.allApps = value;
      _$allAppsAtom.reportChanged();
    }, _$allAppsAtom, name: '${_$allAppsAtom.name}_set');
  }

  final _$initStoreAsyncAction = AsyncAction('initStore');

  @override
  Future<void> initStore() {
    return _$initStoreAsyncAction.run(() => super.initStore());
  }

  final _$saveAsyncAction = AsyncAction('save');

  @override
  Future<void> save(List<AppData> pApps) {
    return _$saveAsyncAction.run(() => super.save(pApps));
  }

  final _$addAsyncAction = AsyncAction('add');

  @override
  Future<void> add(AppData pApp) {
    return _$addAsyncAction.run(() => super.add(pApp));
  }

  final _$renameAsyncAction = AsyncAction('rename');

  @override
  Future<void> rename(AppData pApp) {
    return _$renameAsyncAction.run(() => super.rename(pApp));
  }

  final _$removeAsyncAction = AsyncAction('remove');

  @override
  Future<void> remove(AppData pApp) {
    return _$removeAsyncAction.run(() => super.remove(pApp));
  }
}
