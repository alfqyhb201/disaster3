import 'package:flutter/material.dart';

import '../services/database_services.dart';

class PriceProvider with ChangeNotifier {
  late int _prices4;
  late int _prices5;

  int get prices4 => _prices4;
  int get prices5 => _prices5;

  PriceProvider() {
    DatabaseServices.getAllPrices().then((value) {
      if (value != null) {
        _prices4 = value.first.price;
        _prices5 = value.last.price;
        notifyListeners();
      }
    });
  }
}
