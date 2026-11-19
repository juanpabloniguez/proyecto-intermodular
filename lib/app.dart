import 'package:flutter/material.dart';

import 'screens/main_menu_screen.dart';
import 'theme/app_appearance.dart';
import 'theme/app_theme.dart';

class OldWorldCompanionApp extends StatefulWidget {
  const OldWorldCompanionApp({super.key});

  @override
  State<OldWorldCompanionApp> createState() => _OldWorldCompanionAppState();
}

class _OldWorldCompanionAppState extends State<OldWorldCompanionApp> {
  AppAppearance appearance = AppAppearance.reikland;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Old World Companion',
      theme: buildAppTheme(appearance),
      home: MainMenuScreen(
        appearance: appearance,
        onAppearanceChanged: (value) => setState(() => appearance = value),
      ),
    );
  }
}
