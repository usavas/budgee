import 'package:expenses/dao/monthly_total_amounts_dao.dart';
import 'package:expenses/models/monthly_total.dart';
import 'package:expenses/repositories/predefined_transaction_types_and_cats.dart'
    as p;

class MonthlyTotalAmountsRepository {
  Future<MonthlyTotalAmount> getMonthlyExpenseTransactionTotal(
      int year, int month) {
    return MonthlyTotalAmountsDao().getMonthlyTotalAmounts(
        year,
        month,
        p.transactionCategories
            .where((c) => c.transactionCategoryName == 'expense')
            .first
            .transactionCategoryId);
    // return (res != null) ? res : _getMonthlyAmountWithZero();
  }

  Future<MonthlyTotalAmount> getMonthlyIncomeTransactionTotal(
      int year, int month) {
    return MonthlyTotalAmountsDao().getMonthlyTotalAmounts(
        year,
        month,
        p.transactionCategories
            .where((c) => c.transactionCategoryName == 'income')
            .first
            .transactionCategoryId);
    // return (res != null) ? res : _getMonthlyAmountWithZero();
  }

  // Future<MonthlyTotalAmount> _getMonthlyAmountWithZero() async {
  //   MonthlyTotalAmount amountZero = MonthlyTotalAmount(amount: 0.0);
  //   return amountZero;
  // }
}
