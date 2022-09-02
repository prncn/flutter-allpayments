import 'package:flutter/cupertino.dart';

enum Screen {
  base,
  coupons,
  cards,
  home,
  shortcuts,
}

class Comment {}

class RouteProvider extends ChangeNotifier {
  Screen _current = Screen.coupons;

  Screen get current => _current;

  set current(Screen screen) {
    _current = screen;
    notifyListeners();
  }
}
