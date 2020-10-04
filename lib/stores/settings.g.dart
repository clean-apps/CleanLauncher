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

  final _$useTodoListAtom = Atom(name: '_Settings.useTodoList');

  @override
  bool get useTodoList {
    _$useTodoListAtom.context.enforceReadPolicy(_$useTodoListAtom);
    _$useTodoListAtom.reportObserved();
    return super.useTodoList;
  }

  @override
  set useTodoList(bool value) {
    _$useTodoListAtom.context.conditionallyRunInAction(() {
      super.useTodoList = value;
      _$useTodoListAtom.reportChanged();
    }, _$useTodoListAtom, name: '${_$useTodoListAtom.name}_set');
  }

  final _$useSmallFontAtom = Atom(name: '_Settings.useSmallFont');

  @override
  bool get useSmallFont {
    _$useSmallFontAtom.context.enforceReadPolicy(_$useSmallFontAtom);
    _$useSmallFontAtom.reportObserved();
    return super.useSmallFont;
  }

  @override
  set useSmallFont(bool value) {
    _$useSmallFontAtom.context.conditionallyRunInAction(() {
      super.useSmallFont = value;
      _$useSmallFontAtom.reportChanged();
    }, _$useSmallFontAtom, name: '${_$useSmallFontAtom.name}_set');
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

  final _$setTodoUsageAsyncAction = AsyncAction('setTodoUsage');

  @override
  Future<void> setTodoUsage(bool useTodo) {
    return _$setTodoUsageAsyncAction.run(() => super.setTodoUsage(useTodo));
  }

  final _$setSmallFontAsyncAction = AsyncAction('setSmallFont');

  @override
  Future<void> setSmallFont(bool pUseSmallFont) {
    return _$setSmallFontAsyncAction
        .run(() => super.setSmallFont(pUseSmallFont));
  }
}
