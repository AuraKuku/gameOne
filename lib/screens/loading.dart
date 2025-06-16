import 'package:flutter/material.dart';
import '../services/asset_preloader.dart';
import '../services/yaml_preloader.dart';
import 'main_menu.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _isReady = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _preload();
  }

  Future<void> _preload() async {
    await AssetPreloader.preloadAssets(context);
    await YamlPreloader().preloadYaml();

    setState(() {
      _isReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return const MainMenuScreen();
  }
}