import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';
import 'dart:convert';

class YamlPreloader {
  static final YamlPreloader _instance = YamlPreloader._internal();
  factory YamlPreloader() => _instance;
  YamlPreloader._internal();

  final Map<String, YamlMap> _yamlCache = {};

  Future<void> preloadYaml() async {
    final yamlPrefixes = ['assets/data/', 'assets/yaml/'];
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final yamlPaths = manifestMap.keys
        .where(
          (String key) => yamlPrefixes.any((prefix) => key.startsWith(prefix)),
        )
        .toList();

    for (final path in yamlPaths) {
      final raw = await rootBundle.loadString(path);
      final relativePath = yamlPrefixes.fold(path, (acc, prefix) {
        return acc.startsWith(prefix) ? acc.replaceFirst(prefix, '') : acc;
      });
      _yamlCache[relativePath] = loadYaml(raw);
    }
  }

  /// Get preloaded YAML
  YamlMap? getYaml(String path) => _yamlCache[path];
}
