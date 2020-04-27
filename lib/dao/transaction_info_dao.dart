import '../database/database.dart';
import 'package:expenses/models/transaction_info.dart';
import 'package:sqflite/sqflite.dart';

class TransactionDao {
  Future<List<TransactionInfo>> getTransactions() async {
    Database _db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps =
        await _db.query(DatabaseHelper.transactionInfoTable.tableName);

    return List.generate(
        maps.length, (index) => TransactionInfo.fromDbMap(maps[index]));
  }

  Future<List<TransactionInfo>> getTransactionType() async {
    Database _db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await _db.query(
      DatabaseHelper.transactionInfoTable.tableName,
      columns: [
        'id',
        'transaction_type_id',
        'transaction_date',
        'transaction_note',
      ],
    );
    return List.generate(
        maps.length, (index) => TransactionInfo.fromDbMap(maps[index]));
  }

  Future<List<TransactionInfo>> getTransactionByDates(DateTime start, DateTime end) async {
    Database _db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await _db.query(
        DatabaseHelper.transactionInfoTable.tableName,
        where: 'transaction_date between ? and ?',
        whereArgs: [start, end]);

    return List.generate(
        maps.length, (index) => TransactionInfo.fromDbMap(maps[index]));
  }

  Future<int> insertTransaction(TransactionInfo transaction) async {
    Database _db = await DatabaseHelper.instance.database;

    try {
      return await _db.insert(
          DatabaseHelper.transactionInfoTable.tableName, transaction.toDbMap());
    } catch (e) {
      return -1;
    }
  }

  Future<int> updateTransaction(TransactionInfo transaction) async {
    Database _db = await DatabaseHelper.instance.database;
    return await _db.update(
      DatabaseHelper.transactionInfoTable.tableName,
      transaction.toDbMap(),
      where: "id = ?",
      whereArgs: [transaction.transactionId],
    );
  }

  Future<int> deleteTransactionById(int transactionId) async {
    Database _db = await DatabaseHelper.instance.database;

    return _db.delete(DatabaseHelper.transactionInfoTable.tableName,
        where: 'id = ?', whereArgs: [transactionId]);
  }
}
