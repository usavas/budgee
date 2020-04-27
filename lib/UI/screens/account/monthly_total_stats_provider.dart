import 'package:expenses/models/monthly_total.dart';
import 'package:expenses/repositories/monthly_totals_repository.dart';
import 'package:flutter/cupertino.dart';

class MonthlyTotalStatsProvider with ChangeNotifier {
  Future<List<MonthlyTotalAmount>> monthlyTotals =
      _getMonhtlyTotals(DateTime.now().year, DateTime.now().month);

  setMonthlyTotals(year, month) {
    monthlyTotals = _getMonhtlyTotals(year, month);
    notifyListeners();
  }

  static _getMonhtlyTotals(year, month) {
    return Future.wait([
      MonthlyTotalAmountsRepository()
          .getMonthlyIncomeTransactionTotal(year, month),
      MonthlyTotalAmountsRepository()
          .getMonthlyExpenseTransactionTotal(year, month),
    ]);
  }
}
