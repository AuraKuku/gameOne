import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:jenny/jenny.dart';

class StoryDialogueView implements DialogueView {
  String currentLine = '';
  bool canContinue = false;
  final VoidCallback onDialogueUpdate;
  Completer<bool>? _lineCompleter;

  StoryDialogueView({required this.onDialogueUpdate});

  @override
  FutureOr<bool> onLineStart(DialogueLine line) {
    currentLine = line.text;
    canContinue = true;
    onDialogueUpdate();

    _lineCompleter = Completer<bool>();

    return _lineCompleter!.future;
  }

  @override
  FutureOr<int?> onChoiceStart(DialogueChoice choice) {
    return null;
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
    currentLine = '';
    canContinue = false;
    onDialogueUpdate();
  }

  @override
  FutureOr<void> onDialogueFinish() {
    currentLine = 'Dialogue finished!';
    canContinue = false;
    onDialogueUpdate();
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
}
