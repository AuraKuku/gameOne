import 'package:flutter/material.dart';
import '../enums/screens.dart';
import '../screens/location.dart';
import '../screens/load_save.dart';
import '../screens/story.dart';

class NavigationService {
  static void navigate(BuildContext context, ScreenDestination destination) {
    switch (destination) {
      case ScreenDestination.newGame:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const StoryScreen(name: "intro")),
        );
        break;
      case ScreenDestination.location:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LocationScreen()),
        );
        break;
      case ScreenDestination.load:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LoadSaveScreen()),
        );
        break;
      case ScreenDestination.save:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LoadSaveScreen()),
        );
        break;
      case ScreenDestination.gallery:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const StoryScreen(name: "gallery")),
        );
        break;
      case ScreenDestination.options:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const StoryScreen(name: "options")),
        );
        break;
      case ScreenDestination.exit:
        Navigator.of(context).maybePop();
        break;
      default:
        // Handle other cases or do nothing
        break;
    }
  }
}