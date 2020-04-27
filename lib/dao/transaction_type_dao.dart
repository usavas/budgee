import '../models/transaction_type.dart';
import '../database/database.dart';
import 'package:sqflite/sqflite.dart';

class TransactionTypeDao {
  Future<List<TransactionType>> getTransactionTypes() async {
    Database _db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps =
        await _db.query(DatabaseHelper.transactionTypeTable.tableName);

    return List.generate(
        maps.length, (index) => TransactionType.fromDbMap(maps[index]));
  }

  Future<List<TransactionType>> getTransactionType() async {
    Database _db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await _db.query(
      DatabaseHelper.transactionTypeTable.tableName,
      columns: [
        'transaction_type_id',
        'transaction_cat_id',
        'transaction_type_name',
        'transaction_type_color',
      ],
    );
    return List.generate(
        maps.length, (index) => TransactionType.fromDbMap(maps[index]));
  }

  Future<List<TransactionType>> getTransactionTypeByName(String title) async {
    Database _db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await _db.query(
        DatabaseHelper.transactionTypeTable.tableName,
        where: 'title = ?',
        whereArgs: [title]);

    return List.generate(
        maps.length, (index) => TransactionType.fromDbMap(maps[index]));
  }

  Future<int> insertTransactionType(TransactionType transactionType) async {
    Database _db = await DatabaseHelper.instance.database;

    try {
      return await _db.insert(
          DatabaseHelper.transactionTypeTable.tableName, transactionType.toDbMap());
    } catch (e) {
      return -1;
    }
  }

  Future<int> updateTransactionType(TransactionType transactionType) async {
    Database _db = await DatabaseHelper.instance.database;
    return await _db.update(
      DatabaseHelper.transactionTypeTable.tableName,
      transactionType.toDbMap(),
      where: "transaction_type_name = ?",
      whereArgs: [transactionType.transactionTypeName],
    );
  }

  Future<int> deleteTransactionTypeById(int transactionTypeId) async {
    Database _db = await DatabaseHelper.instance.database;

    return _db.delete(DatabaseHelper.transactionTypeTable.tableName,
        where: 'transaction_type_id = ?', whereArgs: [transactionTypeId]);
  }
}
