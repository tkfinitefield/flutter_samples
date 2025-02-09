import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final commandProvider = AsyncNotifierProvider.family
    .autoDispose<Command<void>, void, CommandModel<void>>(Command<void>.new);

final commandBoolProvider = AsyncNotifierProvider.family
    .autoDispose<Command<bool>, bool?, CommandModel<bool>>(Command<bool>.new);

class Command<T> extends AutoDisposeFamilyAsyncNotifier<T?, CommandModel<T>> {
  @override
  FutureOr<T?> build(CommandModel<T> arg) async {
    return null;
  }

  Future<void> execute() async {
    if (state.isLoading) {
      return;
    }
    final keepAliveLink = ref.keepAlive();
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final value = await arg._execute();
      return value;
    });
    keepAliveLink.close();
  }
}

class CommandModel<T> {
  final FutureOr<T> Function() _function;
  final Object key;

  const CommandModel(this._function, {required this.key});

  FutureOr<T> _execute() async {
    return await _function();
  }

  @override
  bool operator ==(Object other) {
    return other is CommandModel<T> && other.key == key;
  }

  @override
  int get hashCode => key.hashCode;
}
