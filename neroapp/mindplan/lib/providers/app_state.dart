import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  int _currentTabIndex = 0;
  ThemeMode _themeMode = ThemeMode.light;
  String _appTone = 'motivational'; // 'motivational', 'calm', 'fun'

  // Getters
  int get currentTabIndex => _currentTabIndex;
  ThemeMode get themeMode => _themeMode;
  String get appTone => _appTone;

  // Tab navigation
  void setCurrentTab(int index) {
    _currentTabIndex = index;
    notifyListeners();
  }

  // Theme management
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    notifyListeners();
  }

  // App tone
  void setAppTone(String tone) {
    _appTone = tone;
    notifyListeners();
  }
}