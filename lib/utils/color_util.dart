import 'package:flutter/cupertino.dart';

Color _modifyLightness(Color color, [double amount = .1]) {
  // assert(amount >= -1 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Color _modifySaturation(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslSat = hsl.withSaturation((hsl.saturation - amount).clamp(0.0, 1.0));

  return hslSat.toColor();
}

Color darken(Color color, [double amount = .1]) {
  return _modifyLightness(color, -amount);
}

Color lighten(Color color, [double amount = .1]) {
  return _modifyLightness(color, amount);
}

Color desaturate(Color color, [double amount = .1]) {
  return _modifySaturation(color, amount);
}
