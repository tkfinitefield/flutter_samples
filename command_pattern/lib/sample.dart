import 'dart:async';
import 'dart:math';

import 'package:command_pattern/command.dart';
import 'package:command_pattern/repository.dart';
import 'package:command_pattern/sample_state.dart';
import 'package:command_pattern/text_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sampleProvider =
    AsyncNotifierProvider.autoDispose<Sample, SampleState>(Sample.new);

class Sample extends AutoDisposeAsyncNotifier<SampleState> {
  @override
  FutureOr<SampleState> build() async {
    // textInputProvider(filterTextInput) が SubProvider (Sub State Provider) である
    final filter = ref.watch(textInputProvider(filterTextInput));
    final texts = ref.watch(textsRepositoryProvider);
    final filteredTexts = texts
        .where(
            (element) => filter.text.isEmpty || element.contains(filter.text))
        .toList();
    return SampleState(filteredTexts);
  }

  // textInputProvider と使うことにより、TextEditingController 相当の働きをする
  TextInputModel get filterTextInput =>
      TextInputModel(initialText: '3', key: (Sample, #filterText));

  // コマンドパターン
  CommandModel<bool> get addRandomText => CommandModel(
        _addRandomText,
        key: (Sample, #addRandomText),
      );

  Future<bool> _addRandomText() async {
    await Future.delayed(Duration(seconds: 1));
    ref.read(textsRepositoryProvider.notifier).update((current) => [
          ...current,
          Random().nextInt(100).toString(),
        ]);
    return Random().nextBool();
  }

  // コマンドパターン
  CommandModel<void> get changeText => CommandModel(
        _changeText,
        key: (Sample, #changeText),
      );

  Future<void> _changeText() async {
    ref.read(textInputProvider(filterTextInput).notifier).setText('23');
    await Future.delayed(Duration(seconds: 1));
    if (Random().nextBool()) {
      throw Exception('changeText failed');
    }
  }
}
