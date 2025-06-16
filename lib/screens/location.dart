import 'package:flutter/material.dart';

import '../enums/places.dart';
import '../models/place.dart';
import '../models/place_connection.dart';
import '../services/place_loader.dart';

class LocationScreen extends StatefulWidget {
  final PlaceName placeName;
  const LocationScreen({super.key, this.placeName = PlaceName.defaultPlace});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late Place _place;
  late List<Place> _places;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      _places = await PlaceLoader.loadPlacesFromAssets('places.yaml');
      _place = _places.firstWhere((p) => p.name == widget.placeName);
    } catch (e) {
      _place = Place(
        name: PlaceName.defaultPlace,
        background: 'default.png',
        icon: 'icons/default.png',
        connectedPlaces: [
          PlaceConnection(name: PlaceName.office, x: 100, y: 200),
          PlaceConnection(name: PlaceName.park, x: 250, y: 150),
        ],
      );
      _places = [_place];
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(_place.background, fit: BoxFit.cover),
          ),
          // Connected places' icons
          ..._place.connectedPlaces.map(
            (connection) => Positioned(
              left: connection.x,
              top: connection.y,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          LocationScreen(placeName: connection.name),
                    ),
                  );
                },
                child: Image.asset(
                  _places.firstWhere((p) => p.name == connection.name).icon,
                  width: 48,
                  height: 48,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
