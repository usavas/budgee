import 'package:expenses/dao/monthly_transaction_types_totals_dao.dart';
import 'package:expenses/models/monthly_transaction_types_totals.dart';
import 'package:expenses/repositories/predefined_transaction_types_and_cats.dart'
    as p;

class MonthlyTransactionTypesTotalsRepository {
  Future<List<MonthlyTransactionTypesTotal>> getMonthlyExpenseTransactionTypesTotals(
      int year, int month) {
    return MonthlyTransactionTypesTotalsDao().getMonthlyTransactionTypesTotals(
        year,
        month,
        p.transactionCategories
            .where((c) => c.transactionCategoryName == 'expense')
            .first
            .transactionCategoryId);
  }

    Future<List<MonthlyTransactionTypesTotal>> getMonthlyIncomeTransactionTypesTotals(
      int year, int month) {
    return MonthlyTransactionTypesTotalsDao().getMonthlyTransactionTypesTotals(
        year,
        month,
        p.transactionCategories
            .where((c) => c.transactionCategoryName == 'expense')
            .first
            .transactionCategoryId);
  }

}
