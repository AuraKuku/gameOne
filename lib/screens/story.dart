import 'dart:async';
import 'package:flutter/material.dart';
import 'package:game_one/services/yarn_game_bridge.dart';
import 'package:jenny/jenny.dart';
import 'package:flutter/services.dart' show rootBundle;
import './views/story_view.dart';
import 'package:provider/provider.dart';
import '../state/game_state.dart';

class StoryScreen extends StatefulWidget {
  final String name;
  final String startNode;

  const StoryScreen({super.key, required this.name, this.startNode = 'Start'});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  late DialogueRunner _runner;
  late YarnGameBridge _yarnGameBridge;
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
    final gameState = context.read<GameState>();
    final yarnProject = YarnProject();
    _yarnGameBridge = YarnGameBridge(
      gameState: gameState,
      variables: yarnProject.variables,
    );

    final txt = await rootBundle.loadString(
      'assets/scripts/${widget.name}.yarn',
    );
    yarnProject.parse(txt);

    _runner = DialogueRunner(
      yarnProject: yarnProject,
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
      _yarnGameBridge.syncYarnToGameState();
      storyView.continueDialogue();
    }
  }

  void _selectChoice(int choiceIndex) {
    if (storyView.hasChoices) {
      storyView.selectChoice(choiceIndex);
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
            _showChoices(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (isInitialized && storyView.canContinue && !storyView.hasChoices)
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
  
  Widget _showChoices() {
    if (!isInitialized || !storyView.hasChoices) {
      return SizedBox.shrink();
    }
    return Column( 
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      ...[
        SizedBox(height: 20),
        ...storyView.currentChoices.asMap().entries.map((entry) {
          int index = entry.key;
          String choice = entry.value;
          return Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _selectChoice(index),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[100],
                  foregroundColor: Colors.green[800],
                  alignment: Alignment.centerLeft,
                ),
                child: Text('${index + 1}. $choice'),
              ),
            ),
          );
        }), //.toList(),
      ],
      ],
    );
  }
}
