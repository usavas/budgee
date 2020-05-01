import '../database/database.dart';
import '../models/transaction_info_dto.dart';
import 'package:sqflite/sqflite.dart';

class TransactionInfoDtoDao {
  Future<List<TransactionInfoDto>> getTransactionInfoDtosByMonth(
      int year, int month) async {
    String _month = month.toString();
    if (_month.toString().trim().length == 1) {
      _month = '0' + _month.toString();
    }

    Database _db = await DatabaseHelper.instance.database;

    final List<Map<String, dynamic>> maps = await _db.rawQuery(
      '''SELECT t.id, 
      transaction_type_name,
      transaction_type_id,
      tc.transaction_cat_name,
      transaction_cat_id,
      transaction_note,
      transaction_date, 
      transaction_amount,
      transaction_type_icon,
      transaction_type_color
        FROM transaction_info t, transaction_type tt, transaction_cat tc
        WHERE t.transaction_type_id = tt.id 
          AND tt.transaction_cat_id = tc.id
          AND strftime('%Y', datetime(transaction_date,'unixepoch')) = ? 
          AND strftime('%m', datetime(transaction_date,'unixepoch')) = ?
      ORDER BY transaction_date DESC
      ''',
      [year.toString(), _month],
    );

    return List.generate(
        maps.length, (index) => TransactionInfoDto.fromDbMap(maps[index]));
  }
}
