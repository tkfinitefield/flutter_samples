import 'package:command_pattern/command.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommandButton extends ConsumerWidget {
  final CommandModel command;
  final String? message;
  final String? errorMessage;
  final Widget child;

  const CommandButton(
    this.command, {
    super.key,
    this.message,
    this.errorMessage,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(commandProvider(command), (prev, next) {
      if (message != null && prev?.hasValue == true) {
        if (next case AsyncData()) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message!)));
        }
      }
      if (errorMessage != null) {
        if (next case AsyncError()) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage!)));
        }
      }
    });
    return ElevatedButton(
      onPressed: switch (ref.watch(commandProvider(command))) {
        AsyncData() ||
        AsyncError() =>
          ref.read(commandProvider(command).notifier).execute,
        _ => null,
      },
      child: child,
    );
  }
}

class CommandBoolButton extends ConsumerWidget {
  final CommandModel<bool> command;
  final String? trueMessage;
  final String? falseMessage;
  final String? errorMessage;
  final Widget child;

  const CommandBoolButton(
    this.command, {
    super.key,
    this.trueMessage,
    this.falseMessage,
    this.errorMessage,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(commandBoolProvider(command), (prev, next) {
      if (trueMessage != null && prev?.hasValue == true) {
        if (next case AsyncData(value: true)) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(trueMessage!)));
        }
      }
      if (falseMessage != null && prev?.hasValue == true) {
        if (next case AsyncData(value: false)) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(falseMessage!)));
        }
      }
      if (errorMessage != null) {
        if (next case AsyncError()) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMessage!)));
        }
      }
    });
    return ElevatedButton(
      onPressed: switch (ref.watch(commandBoolProvider(command))) {
        AsyncData() ||
        AsyncError() =>
          ref.read(commandBoolProvider(command).notifier).execute,
        _ => null,
      },
      child: child,
    );
  }
}
