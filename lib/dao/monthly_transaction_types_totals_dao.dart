import 'package:expenses/database/database.dart';
import 'package:expenses/models/monthly_transaction_types_totals.dart';
import 'package:sqflite/sqflite.dart';

class MonthlyTransactionTypesTotalsDao {
  Future<List<MonthlyTransactionTypesTotal>> getMonthlyTransactionTypesTotals(
      int year, int month, int transactionCatId) async {
    String _month = month.toString();
    if (_month.toString().trim().length == 1) {
      _month = '0' + _month.toString();
    }
    Database _db = await DatabaseHelper.instance.database;

    final String query = '''
        SELECT 
        strftime('%m', datetime(transaction_date,'unixepoch')) as month_num,
        strftime('%Y', datetime(transaction_date,'unixepoch')) as year_num,
        t.transaction_cat_id,
        c.transaction_cat_name,
        i.transaction_type_id,
        t.transaction_type_name,
		    t.transaction_type_color,
        SUM(transaction_amount) AS total_amount
      FROM transaction_info i, transaction_type t, transaction_cat c
      WHERE i.transaction_type_id = t.id 
        AND t.transaction_cat_id = c.id
        AND month_num = ? 
        AND year_num = ?
        AND c.id = ?
      GROUP BY 	transaction_type_id,
        transaction_type_name,
        i.transaction_type_id,
        t.transaction_type_name,
        year_num,
        month_num;
      ''';

    final List<Map<String, dynamic>> maps =
        await _db.rawQuery(query, [_month, year.toString(), transactionCatId]);

    return List.generate(maps.length,
        (index) => MonthlyTransactionTypesTotal.fromDbMap(maps[index]));
  }
}
