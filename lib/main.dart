import 'package:flutter/material.dart';
import 'package:joola/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:joola/src/app.dart';
import 'package:joola/src/settings/settings_controller.dart';
import 'package:joola/src/settings/settings_service.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  WidgetsFlutterBinding.ensureInitialized();

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(Application(settingsController: settingsController));
}
