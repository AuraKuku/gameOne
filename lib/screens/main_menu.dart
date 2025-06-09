import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../enums/screens.dart';
import '../services/navigation_service.dart';

class MainMenuScreen extends StatelessWidget  {
  const MainMenuScreen({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/main_menu/back.png',
              fit: BoxFit.cover,
            ),
          ),

          // Main UI: left (menu) and right (transparent image B)
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MenuButton(label: 'New Game', destination: ScreenDestination.newGame,),
                      MenuButton(label: 'Load', destination: ScreenDestination.load,),
                      MenuButton(label: 'Gallery', destination: ScreenDestination.gallery,),
                      MenuButton(label: 'Options', destination: ScreenDestination.options,),
                      MenuButton(label: 'Exit', destination: ScreenDestination.exit,),
                    ],
                  ),
                ),
              ),

              Expanded(
                flex: 7,
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/sophie.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String label;
  final ScreenDestination destination;

  const MenuButton({
    super.key,
    required this.label,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black.withOpacity(0.6),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 40),
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () => NavigationService.navigate(context, destination),
        child: Text(label),
      ),
    );
  }
}
