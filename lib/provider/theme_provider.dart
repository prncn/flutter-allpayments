import 'package:allpayments/assets/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  bool get isDarkMode => themeMode == ThemeMode.dark;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  bool _isDrawerOpen = false;
  late AnimationController drawerIconController;

  bool get isDrawerOpen => _isDrawerOpen;
  set isDrawerOpen(var value) {
    _isDrawerOpen = value;
    notifyListeners();
  }

  void toggleTheme() {
    if (themeMode == ThemeMode.dark) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }
}

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: darkSlate,
  backgroundColor: darkSlate,
  cardColor: offBlack,
  colorScheme: const ColorScheme.dark().copyWith(
    surface: darkSlate,
  ),
  fontFamily: GoogleFonts.lato().fontFamily,
);

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: backgroundColor,
  backgroundColor: backgroundColor,
  cardColor: Colors.white,
  colorScheme: const ColorScheme.light().copyWith(
    surface: backgroundColor,
  ),
  fontFamily: GoogleFonts.lato().fontFamily,
);
