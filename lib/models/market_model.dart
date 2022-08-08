import 'package:flutter/cupertino.dart';

class MarketData {
  final String name;
  final Color color;

  Image get logo => Image.asset(
        'images/market_logos/${name.toLowerCase()}.webp',
        fit: BoxFit.contain,
        height: 120,
      );

  const MarketData(this.name, this.color);
}

const MarketData reweMarket = MarketData('Rewe', Color(0xffcc071e));
const MarketData edekaMarket = MarketData('Edeka', Color(0xfff8ec00));
const MarketData nettoMarket = MarketData('Netto', Color(0xffffe500));
const MarketData pennyMarket = MarketData('Penny', Color(0xffcc1700));
const MarketData dmMarket = MarketData('dm', Color(0xfff6f9fa));
