import 'package:yaml/yaml.dart';

import '../models/place.dart';
import 'yaml_preloader.dart';

class PlaceLoader {
  static Future<List<Place>> loadPlacesFromAssets(String assetPath) async {
    
    try {
      return loadPlacesFromYaml(YamlPreloader().getYaml(assetPath));
    } catch (e) {
      throw Exception('Failed to load places from assets: $e');
    }
  }

  static List<Place> loadPlacesFromYaml(YamlMap? yamlMap) {
    try {
      final List<Place> places = [];

      if (yamlMap is! YamlMap) {
        throw Exception('Invalid YAML format: expected a map at root level');
      }

      // Parse each place
      yamlMap.forEach((key, value) {
        if (value is YamlMap) {
          places.add(Place.fromMap(key.toString().trim(), _yamlMapToMap(value)));
        }
      });

      return places;
    } catch (e) {
      throw Exception('Failed to parse YAML: $e');
    }
  }

  /// Helper method to convert YamlMap to regular Map
  static Map<String, dynamic> _yamlMapToMap(YamlMap yamlMap) {
    Map<String, dynamic> map = {};
    
    yamlMap.forEach((key, value) {
      if (value is YamlMap) {
        map[key.toString()] = _yamlMapToMap(value);
      } else if (value is YamlList) {
        map[key.toString()] = _yamlListToList(value);
      } else {
        map[key.toString()] = value;
      }
    });
    
    return map;
  }

  /// Helper method to convert YamlList to regular List
  static List<dynamic> _yamlListToList(YamlList yamlList) {
    return yamlList.map((item) {
      if (item is YamlMap) {
        return _yamlMapToMap(item);
      } else if (item is YamlList) {
        return _yamlListToList(item);
      } else {
        return item;
      }
    }).toList();
  }
}