import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme/app_theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: AIPhotoGenerator(),
    ),
  );
}

class AIPhotoGenerator extends StatelessWidget {
  const AIPhotoGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AI Photo Generator",
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}