import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextInputModel {
  final String initialText;
  final Object key;

  const TextInputModel({this.initialText = '', required this.key});

  @override
  String toString() {
    return 'initialText: $initialText, key: $key';
  }

  @override
  bool operator ==(Object other) {
    return other is TextInputModel && other.key == key;
  }

  @override
  int get hashCode => key.hashCode;
}

class TextInputState {
  final String text;
  final bool dirty;

  const TextInputState(this.text, this.dirty);

  @override
  String toString() {
    return 'text: $text, dirty: $dirty';
  }
}

final textInputProvider = NotifierProvider.autoDispose
    .family<TextInput, TextInputState, TextInputModel>(TextInput.new);

class TextInput
    extends AutoDisposeFamilyNotifier<TextInputState, TextInputModel> {
  @override
  TextInputState build(TextInputModel arg) {
    return TextInputState(arg.initialText, false);
  }

  void setText(String value) {
    state = TextInputState(value, state.dirty || arg.initialText != value);
  }
}
