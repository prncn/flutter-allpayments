import 'package:allpayments/models/market_model.dart';
import 'package:flutter/cupertino.dart';

class MarketProvider extends ChangeNotifier {
  MarketData _market = pennyMarket;

  MarketData get market => _market;

  set market(MarketData market) {
    _market = market;
    notifyListeners();
  }
}
