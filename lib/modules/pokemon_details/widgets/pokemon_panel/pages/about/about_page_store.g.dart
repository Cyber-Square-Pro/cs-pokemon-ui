// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AboutPageStore on AboutPageStoreBase, Store {
  Computed<Duration>? _$audioProgressComputed;

  @override
  Duration get audioProgress =>
      (_$audioProgressComputed ??= Computed<Duration>(() => super.audioProgress,
              name: 'AboutPageStoreBase.audioProgress'))
          .value;
  Computed<Duration>? _$audioTotalComputed;

  @override
  Duration get audioTotal =>
      (_$audioTotalComputed ??= Computed<Duration>(() => super.audioTotal,
              name: 'AboutPageStoreBase.audioTotal'))
          .value;

  late final _$_audioProgressAtom =
      Atom(name: 'AboutPageStoreBase._audioProgress', context: context);

  @override
  Duration get _audioProgress {
    _$_audioProgressAtom.reportRead();
    return super._audioProgress;
  }

  @override
  set _audioProgress(Duration value) {
    _$_audioProgressAtom.reportWrite(value, super._audioProgress, () {
      super._audioProgress = value;
    });
  }

  late final _$_audioTotalAtom =
      Atom(name: 'AboutPageStoreBase._audioTotal', context: context);

  @override
  Duration get _audioTotal {
    _$_audioTotalAtom.reportRead();
    return super._audioTotal;
  }

  @override
  set _audioTotal(Duration value) {
    _$_audioTotalAtom.reportWrite(value, super._audioTotal, () {
      super._audioTotal = value;
    });
  }

  late final _$AboutPageStoreBaseActionController =
      ActionController(name: 'AboutPageStoreBase', context: context);

  @override
  void setAudioProgress(Duration audioProgress) {
    final _$actionInfo = _$AboutPageStoreBaseActionController.startAction(
        name: 'AboutPageStoreBase.setAudioProgress');
    try {
      return super.setAudioProgress(audioProgress);
    } finally {
      _$AboutPageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAudioTotal(Duration audioTotal) {
    final _$actionInfo = _$AboutPageStoreBaseActionController.startAction(
        name: 'AboutPageStoreBase.setAudioTotal');
    try {
      return super.setAudioTotal(audioTotal);
    } finally {
      _$AboutPageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
audioProgress: ${audioProgress},
audioTotal: ${audioTotal}
    ''';
  }
}
