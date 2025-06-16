import 'package:game_one/enums/places.dart';

class PlaceConnection {
  final PlaceName name;
  final double x;
  final double y;

  const PlaceConnection({
    required this.name,
    required this.x,
    required this.y,
  });

  factory PlaceConnection.fromMap(Map<String, dynamic> map) {
    return PlaceConnection(
      name: PlaceName.fromString(map['name'] as String),
      x: (map['x'] as num).toDouble(),
      y: (map['y'] as num).toDouble(),
    );
  }

  @override
  String toString() => 'PlaceConnection(name: $name, x: $x, y: $y)';
}