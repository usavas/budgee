import 'package:expenses/models/monthly_total.dart';
import 'package:flutter/material.dart';
import 'package:expenses/repositories/monthly_totals_repository.dart';

class MonthlyTotalsProvider with ChangeNotifier {
  Future<MonthlyTotalAmount> getMonthlyIncomeTotals(int year, int month) {
    return MonthlyTotalAmountsRepository()
        .getMonthlyIncomeTransactionTotal(year, month);
  }

  Future<MonthlyTotalAmount> getMonthlyExpenseTotals(int year, int month) {
    return MonthlyTotalAmountsRepository()
        .getMonthlyExpenseTransactionTotal(year, month);
  }

  notifyListernersCustom() {
    notifyListeners();
  }
}
