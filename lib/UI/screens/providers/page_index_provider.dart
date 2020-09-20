import 'package:flutter/material.dart';

class PageIndexProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int getIndex() {
    return _selectedIndex;
  }

  setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
