import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jenny/jenny.dart';
import 'package:flutter/services.dart' show rootBundle;
import './views/story_view.dart';

class StoryScreen extends StatefulWidget {
  final String name;
  final String startNode;

  const StoryScreen({super.key, required this.name, this.startNode = 'Start'});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  late DialogueRunner _runner;
  late StoryDialogueView storyView = StoryDialogueView(
    onDialogueUpdate: () {
      setState(() {});
    },
  );
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initDialogue();
  }

  Future<void> _initDialogue() async {
    final txt = await rootBundle.loadString(
      'assets/scripts/${widget.name}.yarn',
    );
    _runner = DialogueRunner(
      yarnProject: YarnProject()..parse(txt),
      dialogueViews: [storyView],
    );
    setState(() {
      isInitialized = true;
    });
    _startDialogue();
  }

  void _startDialogue() {
    if (isInitialized) {
      _runner.startDialogue(widget.startNode);
    }
  }

  void _nextLine() {
    if (storyView.canContinue) {
      storyView.continueDialogue();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              storyView.currentLine,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startDialogue,
              child: const Text('Start Dialogue'),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (isInitialized && storyView.canContinue)
                  ? _nextLine
                  : null,
              child: const Text('Next Line'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
