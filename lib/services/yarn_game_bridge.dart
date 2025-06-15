import 'package:jenny/jenny.dart';
import 'package:game_one/state/game_state.dart';

class YarnGameBridge {
  final GameState gameState;
  final VariableStorage variables;

  bool _syncing = false;

  YarnGameBridge({required this.gameState, required this.variables}) {
    _initListeners();
    _syncGameStateToYarn();
  }

  void _initListeners() {
    // Listen to GameState changes and update Yarn
    gameState.addListener(() {
      if (_syncing) return;
      _syncing = true;
      _syncGameStateToYarn();
      _syncing = false;
    });
  }

  void _syncGameStateToYarn() {
    variables.setVariable(r'$money', gameState.playerMoney.toDouble());
    variables.setVariable(r'$health', gameState.playerHealth.toDouble());
    variables.setVariable(r'$power', gameState.playerPower.toDouble());
    // Add more variables as needed
  }

  void syncYarnToGameState() {
    _syncing = true;
    gameState.playerMoney =
        variables.getVariable(r'$money')?.toInt() ?? gameState.playerMoney;
    gameState.playerHealth =
        variables.getVariable(r'$health')?.toInt() ?? gameState.playerHealth;
    gameState.playerPower =
        variables.getVariable(r'$power')?.toInt() ?? gameState.playerPower;
    _syncing = false;
  }
}