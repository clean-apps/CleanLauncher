// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appdata.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppData on _AppData, Store {
  final _$appNameAtom = Atom(name: '_AppData.appName');

  @override
  String get appName {
    _$appNameAtom.context.enforceReadPolicy(_$appNameAtom);
    _$appNameAtom.reportObserved();
    return super.appName;
  }

  @override
  set appName(String value) {
    _$appNameAtom.context.conditionallyRunInAction(() {
      super.appName = value;
      _$appNameAtom.reportChanged();
    }, _$appNameAtom, name: '${_$appNameAtom.name}_set');
  }

  final _$packageNameAtom = Atom(name: '_AppData.packageName');

  @override
  String get packageName {
    _$packageNameAtom.context.enforceReadPolicy(_$packageNameAtom);
    _$packageNameAtom.reportObserved();
    return super.packageName;
  }

  @override
  set packageName(String value) {
    _$packageNameAtom.context.conditionallyRunInAction(() {
      super.packageName = value;
      _$packageNameAtom.reportChanged();
    }, _$packageNameAtom, name: '${_$packageNameAtom.name}_set');
  }

  final _$_AppDataActionController = ActionController(name: '_AppData');

  @override
  dynamic fromJson(dynamic json) {
    final _$actionInfo = _$_AppDataActionController.startAction();
    try {
      return super.fromJson(json);
    } finally {
      _$_AppDataActionController.endAction(_$actionInfo);
    }
  }
}
