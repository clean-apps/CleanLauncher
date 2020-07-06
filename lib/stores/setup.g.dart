// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setup.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Setup on _Setup, Store {
  final _$isLoadingDoneAtom = Atom(name: '_Setup.isLoadingDone');

  @override
  bool get isLoadingDone {
    _$isLoadingDoneAtom.context.enforceReadPolicy(_$isLoadingDoneAtom);
    _$isLoadingDoneAtom.reportObserved();
    return super.isLoadingDone;
  }

  @override
  set isLoadingDone(bool value) {
    _$isLoadingDoneAtom.context.conditionallyRunInAction(() {
      super.isLoadingDone = value;
      _$isLoadingDoneAtom.reportChanged();
    }, _$isLoadingDoneAtom, name: '${_$isLoadingDoneAtom.name}_set');
  }

  final _$isSetupDoneAtom = Atom(name: '_Setup.isSetupDone');

  @override
  bool get isSetupDone {
    _$isSetupDoneAtom.context.enforceReadPolicy(_$isSetupDoneAtom);
    _$isSetupDoneAtom.reportObserved();
    return super.isSetupDone;
  }

  @override
  set isSetupDone(bool value) {
    _$isSetupDoneAtom.context.conditionallyRunInAction(() {
      super.isSetupDone = value;
      _$isSetupDoneAtom.reportChanged();
    }, _$isSetupDoneAtom, name: '${_$isSetupDoneAtom.name}_set');
  }

  final _$initStoreAsyncAction = AsyncAction('initStore');

  @override
  Future<void> initStore() {
    return _$initStoreAsyncAction.run(() => super.initStore());
  }
}
