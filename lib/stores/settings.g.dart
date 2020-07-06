// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Settings on _Settings, Store {
  final _$useLightThemeAtom = Atom(name: '_Settings.useLightTheme');

  @override
  bool get useLightTheme {
    _$useLightThemeAtom.context.enforceReadPolicy(_$useLightThemeAtom);
    _$useLightThemeAtom.reportObserved();
    return super.useLightTheme;
  }

  @override
  set useLightTheme(bool value) {
    _$useLightThemeAtom.context.conditionallyRunInAction(() {
      super.useLightTheme = value;
      _$useLightThemeAtom.reportChanged();
    }, _$useLightThemeAtom, name: '${_$useLightThemeAtom.name}_set');
  }

  final _$initStoreAsyncAction = AsyncAction('initStore');

  @override
  Future<void> initStore() {
    return _$initStoreAsyncAction.run(() => super.initStore());
  }

  final _$setThemeAsyncAction = AsyncAction('setTheme');

  @override
  Future<void> setTheme(bool lightMode) {
    return _$setThemeAsyncAction.run(() => super.setTheme(lightMode));
  }
}
