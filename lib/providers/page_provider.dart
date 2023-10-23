import 'package:flutter/material.dart';

class PageProvider with ChangeNotifier {
  int _pageNumber = 0;
  int get pageNumber => _pageNumber;

  changePageNumber(int num) {
    _pageNumber = num;
    notifyListeners();
  }
}
