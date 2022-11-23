import 'package:flutter/material.dart';

Color lightCream = const Color(0xfffff9f2);
Color backgroundColor = const Color(0xfff6f9fa);

Color darkGray = const Color(0xff26374b);
Color darkSlate = const Color(0xff1d1e24);
Color offBlack = const Color(0xff17181d);

Color cgiRed = const Color(0xffe31837);
Color cgiPurple = const Color(0xff5236ab);
Color cgiPurpleSat = const Color(0xff6c46e4);

LinearGradient redGradient = LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
  stops: const [0, 0.6],
  colors: [
    const Color(0xffe36a90),
    cgiRed,
  ],
);

LinearGradient cgiGradientPrimary = LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
  stops: const [0, 0.6],
  colors: [
    cgiRed,
    cgiPurple,
  ],
);
