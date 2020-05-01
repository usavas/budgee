import 'package:expenses/database/database.dart';
import 'package:expenses/models/monthly_total.dart';
import 'package:sqflite/sqflite.dart';

class MonthlyTotalAmountsDao {
  Future<MonthlyTotalAmount> getMonthlyTotalAmounts(
      int year, int month, int transactionCatId) async {
    String _month = month.toString();
    if (_month.toString().trim().length == 1) {
      _month = '0' + _month.toString();
    }
    Database _db = await DatabaseHelper.instance.database;

    final String query = '''
        SELECT 
          SUM(transaction_amount) as total
          ,strftime('%m', datetime(transaction_date,'unixepoch')) as month_num
          ,strftime('%Y', datetime(transaction_date,'unixepoch')) as year_num
        FROM transaction_info
        WHERE 
          month_num = ? AND
          year_num = ? AND
          transaction_type_id IN 
          (SELECT t.id FROM transaction_type t, transaction_cat c 
          WHERE t.transaction_cat_id = c.id AND c.id = ?)
        GROUP BY month_num, year_num
      ''';

    final List<Map<String, dynamic>> maps =
        await _db.rawQuery(query, [_month, year.toString(), transactionCatId]);

    return (maps.length == 0)
        ? MonthlyTotalAmount(amount: 0.0)
        : List.generate(maps.length,
            (index) => MonthlyTotalAmount.fromDbMap(maps[index])).first;
  }
}
