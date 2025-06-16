import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AssetPreloader {
  
  static Future<void> preloadAssets(BuildContext context) async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final imagePaths = manifestMap.keys
        .where((String key) => key.startsWith('assets/images/'))
        .toList();

    for (final path in imagePaths) {
      await precacheImage(AssetImage(path), context);
    }
  }
}
