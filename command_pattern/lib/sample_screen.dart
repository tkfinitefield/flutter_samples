import 'package:command_pattern/command_button.dart';
import 'package:command_pattern/sample.dart';
import 'package:command_pattern/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SampleScreen extends ConsumerStatefulWidget {
  const SampleScreen({super.key});

  @override
  ConsumerState<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends ConsumerState<SampleScreen> {
  @override
  Widget build(BuildContext context) {
    final sample = ref.watch(sampleProvider.notifier);
    final sampleState = ref.watch(sampleProvider);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Sample'),
              for (var text in sampleState.valueOrNull?.texts ?? []) Text(text),
              CommandButton(
                sample.changeText,
                message: 'change filter text done',
                errorMessage: 'change filter text error',
                child: Text('change filter text'),
              ),
              CommandBoolButton(
                sample.addRandomText,
                trueMessage: 'addRandomText success',
                falseMessage: 'addRandomText failed',
                errorMessage: 'addRandomText error',
                child: Text('addRandomText'),
              ),
              TextInputField(sample.filterTextInput),
            ],
          ),
        ),
      ),
    );
  }
}
