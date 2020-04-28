import '../database/database.dart';
import '../models/transaction_info_dto.dart';
import 'package:sqflite/sqflite.dart';

class TransactionInfoDtoDao {
  Future<List<TransactionInfoDto>> getTransactionInfoDtosBetween(
      DateTime start, DateTime end) async {
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
      transaction_type_icon
        FROM transaction_info t, transaction_type tt, transaction_cat tc
        WHERE t.transaction_type_id = tt.id AND tt.transaction_cat_id = tc.id
        AND transaction_date between ? and ?
      ''',
      <dynamic>[start, end],
    );

    return List.generate(
        maps.length, (index) => TransactionInfoDto.fromDbMap(maps[index]));
  }

  Future<List<TransactionInfoDto>> getTransactionInfoDtos() async {
    Database _db = await DatabaseHelper.instance.database;

    final List<Map<String, dynamic>> maps = await _db.rawQuery('''SELECT t.id, 
      transaction_type_name,
      transaction_type_id,
      transaction_cat_name,
      transaction_cat_id,
      transaction_note, 
      transaction_date, 
      transaction_amount,
      transaction_type_icon
        FROM transaction_info t, transaction_type tt, transaction_cat tc
        WHERE t.transaction_type_id = tt.id AND tt.transaction_cat_id = tc.id
      ''');

    return List.generate(
        maps.length, (index) => TransactionInfoDto.fromDbMap(maps[index]));
  }
}
