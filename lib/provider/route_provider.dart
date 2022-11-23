import 'package:flutter/cupertino.dart';

enum Screen {
  base,
  coupons,
  cards,
  home,
  shortcuts,
}

class RouteProvider extends ChangeNotifier {
  Screen _current = Screen.coupons;
  int _navigationIndex = 0;

  Screen get current => _current;
  int get navigationIndex => _navigationIndex;

  set current(Screen screen) {
    _current = screen;
    notifyListeners();
  }

  set navigationIndex(int index) {
    _navigationIndex = index;
    notifyListeners();
  }
}
