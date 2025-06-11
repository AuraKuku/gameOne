import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:jenny/jenny.dart';

class StoryDialogueView implements DialogueView {
  String currentLine = '';
  bool canContinue = false;
  bool hasChoices = false;
  List<String> currentChoices = [];
  final VoidCallback onDialogueUpdate;

  Completer<bool>? _lineCompleter;
  Completer<int>? _choiceCompleter;

  StoryDialogueView({required this.onDialogueUpdate});

  @override
  FutureOr<bool> onLineStart(DialogueLine line) {
    currentLine = line.text;
    canContinue = true;
    hasChoices = false;
    currentChoices.clear();
    onDialogueUpdate();

    _lineCompleter = Completer<bool>();

    return _lineCompleter!.future;
  }

  @override
  FutureOr<int?> onChoiceStart(DialogueChoice choice) {
    hasChoices = true;
    canContinue = false;
    currentChoices = choice.options.map((option) => option.text).toList();
    onDialogueUpdate();

    _choiceCompleter = Completer<int>();

    return _choiceCompleter!.future;
  }

  @override
  Future<void> onNodeFinish(Node node) async {
    // onEnd();
  }

  // Optional stubs
  @override
  Future<void> onLineFinish(DialogueLine line) async {}
  @override
  Future<void> onChoiceFinish(DialogueOption option) async {}
  @override
  Future<void> onNodeStart(Node node) async {}

  @override
  FutureOr<void> onDialogueStart() {
    _setInitialData('');
  }

  @override
  FutureOr<void> onDialogueFinish() {
    _setInitialData('Dialogue finished!');
  }

  @override
  DialogueRunner? dialogueRunner;

  @override
  FutureOr<void> onCommand(UserDefinedCommand command) {
    // TODO: implement onCommand
    throw UnimplementedError();
  }

  @override
  void onLineSignal(DialogueLine line, signal) {
    // TODO: implement onLineSignal
  }

  @override
  FutureOr<void> onLineStop(DialogueLine line) {
    // TODO: implement onLineStop
    throw UnimplementedError();
  }

  void continueDialogue() {
    if (canContinue && _lineCompleter != null && !_lineCompleter!.isCompleted) {
      canContinue = false;
      onDialogueUpdate();

      // Complete the future with 'true' to signal dialogue should continue
      _lineCompleter!.complete(true);
      _lineCompleter = null;
    }
  }

  void selectChoice(int choiceIndex) {
    if (hasChoices &&
        _choiceCompleter != null &&
        !_choiceCompleter!.isCompleted) {
      hasChoices = false;
      currentChoices.clear();
      onDialogueUpdate();

      // Complete the future with the selected choice index
      _choiceCompleter!.complete(choiceIndex);
      _choiceCompleter = null;
    }
  }

  void _setInitialData(String initialLine) {
    currentLine = initialLine;
    canContinue = false;
    hasChoices = false;
    currentChoices.clear();
    onDialogueUpdate();
  }
}
