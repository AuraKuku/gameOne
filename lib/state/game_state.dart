import 'dart:convert';
import 'package:flutter/foundation.dart';

enum TimeSlot { morning, day, evening, night }

class GameState extends ChangeNotifier {
  String currentLocation;
  TimeSlot currentTime;

  int _playerHealth;
  int _playerMoney;
  int _playerPower;

  Map<String, int> catHealth; // catName -> health
  Map<String, int> inventory; // itemName -> quantity

  GameState({
    required this.currentLocation,
    required this.currentTime,
    required int playerHealth,
    required int playerMoney,
    required int playerPower,
    required this.catHealth,
    required this.inventory,
  })  : _playerHealth = playerHealth,
        _playerMoney = playerMoney,
        _playerPower = playerPower;

  // Default state
  factory GameState.initial() {
    return GameState(
      currentLocation: "Home",
      currentTime: TimeSlot.morning,
      playerHealth: 100,
      playerMoney: 50,
      playerPower: 10,
      catHealth: {},
      inventory: {},
    );
  }

  int get playerMoney => _playerMoney;
  set playerMoney(int val) {
    if (_playerMoney != val) {
      _playerMoney = val;
      notifyListeners();
    }
  }

  int get playerHealth => _playerHealth;
  set playerHealth(int val) {
    if (_playerHealth != val) {
      _playerHealth = val;
      notifyListeners();
    }
  }

  int get playerPower => _playerPower;
  set playerPower(int val) {
    if (_playerPower != val) {
      _playerPower = val;
      notifyListeners();
    }
  }

  // Serialize to JSON
  Map<String, dynamic> toJson() => {
        'currentLocation': currentLocation,
        'currentTime': currentTime.name,
        'playerHealth': playerHealth,
        'playerMoney': playerMoney,
        'playerPower': playerPower,
        'catHealth': catHealth,
        'inventory': inventory,
      };

  // Deserialize from JSON
  factory GameState.fromJson(Map<String, dynamic> json) {
    return GameState(
      currentLocation: json['currentLocation'] ?? 'Home',
      currentTime: TimeSlot.values.byName(json['currentTime']),
      playerHealth: json['playerHealth'] ?? 100,
      playerMoney: json['playerMoney'] ?? 0,
      playerPower: json['playerPower'] ?? 0,
      catHealth: Map<String, int>.from(json['catHealth'] ?? {}),
      inventory: Map<String, int>.from(json['inventory'] ?? {}),
    );
  }

  // Save to string (e.g. SharedPreferences, file, etc.)
  String encode() => jsonEncode(toJson());

  // Load from string
  static GameState decode(String data) =>
      GameState.fromJson(jsonDecode(data));
}