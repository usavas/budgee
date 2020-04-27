import '../database/database.dart';
import '../models/transaction_info_dto.dart';
import 'package:sqflite/sqflite.dart';


class TransactionInfoDtoDao{
  Future<List<TransactionInfoDto>> getTransactionInfoDtosBetween(DateTime start, DateTime end) async {
    Database _db = await DatabaseHelper.instance.database;

    final List<Map<String, dynamic>> maps = await _db.rawQuery(
      '''SELECT t.id, 
      transaction_type_name,
      transaction_type_id,
      transaction_note, 
      transaction_date, 
      transaction_amount
        FROM transaction t, transaction_type tt
        WHERE t.transaction_type_id = tt.transaction_type_id 
        AND transaction_date between ? and ?
      ''',
        <dynamic>[start, end],);

    return List.generate(
        maps.length, (index) => TransactionInfoDto.fromDbMap(maps[index]));
  }


  Future<List<TransactionInfoDto>> getTransactionInfoDtos() async {
    Database _db = await DatabaseHelper.instance.database;

    final List<Map<String, dynamic>> maps = await _db.rawQuery(
      '''SELECT t.id, 
      transaction_type_name,
      transaction_type_id,
      transaction_note, 
      transaction_date, 
      transaction_amount
        FROM transaction_info t, transaction_type tt
        WHERE t.transaction_type_id = tt.id
      ''');

    return List.generate(
        maps.length, (index) => TransactionInfoDto.fromDbMap(maps[index]));
  }
  


}