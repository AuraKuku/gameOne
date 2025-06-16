import '../enums/places.dart';
import 'place_connection.dart';

class Place {
  final PlaceName name;
  final String _background;
  final String _icon;
  final List<PlaceConnection> connectedPlaces;

  Place({
    required this.name,
    String? background,
    String? icon,
    List<PlaceConnection>? connectedPlaces,
  })  : _background = background ?? '${name.value}.png',
        _icon = icon ?? 'icons/${name.value}.png',
        connectedPlaces = connectedPlaces ?? [];

  factory Place.fromMap(String nameStr, Map<String, dynamic> map) {
    final placeName = PlaceName.fromString(nameStr);
    
    // Parse connected places
    List<PlaceConnection> connections = [];
    final connectedData = map['connectedPlaces'];
    
    if (connectedData is List) {
      // Handle list format
      for (var connection in connectedData) {
        if (connection is Map) {
          connections.add(PlaceConnection.fromMap(
            Map<String, dynamic>.from(connection)));
        }
      }
    } else if (connectedData is Map) {
      // Handle map format where each key is a place name
      connectedData.forEach((key, value) {
        if (value is Map) {
          final connectionMap = Map<String, dynamic>.from(value);
          connectionMap['name'] = key;
          connections.add(PlaceConnection.fromMap(connectionMap));
        }
      });
    }

    return Place(
      name: placeName,
      background: map['background'] as String?,
      icon: map['icon'] as String?,
      connectedPlaces: connections,
    );
  }

  @override
  String toString() {
    return 'Place(name: $name, background: $background, icon: $icon, '
           'connectedPlaces: $connectedPlaces)';
  }
  
   String get icon => 'assets/images/locations/$_icon';
   String get background => 'assets/images/locations/$_background';
}