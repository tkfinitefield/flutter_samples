import 'package:command_pattern/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextInputField extends ConsumerStatefulWidget {
  final TextInputModel textInput;

  const TextInputField(
    this.textInput, {
    super.key,
  });

  @override
  ConsumerState<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends ConsumerState<TextInputField> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _textController.text = widget.textInput.initialText;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(textInputProvider(widget.textInput), (prev, next) {
      if (_textController.text != next.text) {
        _textController.text = next.text;
      }
    });
    return TextFormField(
      controller: _textController,
      onChanged: (value) {
        ref.read(textInputProvider(widget.textInput).notifier).setText(value);
      },
    );
  }
}
