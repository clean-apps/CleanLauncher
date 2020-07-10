// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taskdata.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TaskData on _TaskData, Store {
  final _$descriptionAtom = Atom(name: '_TaskData.description');

  @override
  String get description {
    _$descriptionAtom.context.enforceReadPolicy(_$descriptionAtom);
    _$descriptionAtom.reportObserved();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.context.conditionallyRunInAction(() {
      super.description = value;
      _$descriptionAtom.reportChanged();
    }, _$descriptionAtom, name: '${_$descriptionAtom.name}_set');
  }

  final _$completedAtom = Atom(name: '_TaskData.completed');

  @override
  bool get completed {
    _$completedAtom.context.enforceReadPolicy(_$completedAtom);
    _$completedAtom.reportObserved();
    return super.completed;
  }

  @override
  set completed(bool value) {
    _$completedAtom.context.conditionallyRunInAction(() {
      super.completed = value;
      _$completedAtom.reportChanged();
    }, _$completedAtom, name: '${_$completedAtom.name}_set');
  }

  final _$_TaskDataActionController = ActionController(name: '_TaskData');

  @override
  dynamic toggle() {
    final _$actionInfo = _$_TaskDataActionController.startAction();
    try {
      return super.toggle();
    } finally {
      _$_TaskDataActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic fromJson(dynamic json) {
    final _$actionInfo = _$_TaskDataActionController.startAction();
    try {
      return super.fromJson(json);
    } finally {
      _$_TaskDataActionController.endAction(_$actionInfo);
    }
  }
}
