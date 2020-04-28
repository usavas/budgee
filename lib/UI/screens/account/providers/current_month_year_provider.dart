import 'package:flutter/cupertino.dart';

class CurrentMonthYearProvider with ChangeNotifier {
  int _currentMonth = DateTime.now().month;
  int _currentYear = DateTime.now().year;

  increaseMonth() {
    if (_currentMonth == 12) {
      _currentMonth = 1;
      _currentYear += 1;
    } else {
      _currentMonth += 1;
    }

    notifyListeners();
  }

  decreaseMonth() {
    if (_currentMonth == 1) {
      _currentYear -= 1;
      _currentMonth = 12;
    } else {
      _currentMonth -= 1;
    }

    notifyListeners();
  }

  get currentYear {
    return _currentYear;
  }

  get currentMonth {
    return _currentMonth;
  }
}
