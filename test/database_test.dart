import 'package:expenses/repositories/predefined_transaction_types_and_cats.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expenses/database/database_naming_helper.dart';
import 'dart:io';

void main() {
  test('database created successfully with foreign key to another table', () {
    DatabaseTable transactionCategoryTable =
        DatabaseTable(tableName: 'transaction_cat', columns: [
      DatabaseColumn(isIdColumn: true),
    ]);

    DatabaseTable transactionTypeTable = DatabaseTable(
        tableName: 'transaction_type',
        columns: [
          DatabaseColumn(isIdColumn: true),
          DatabaseColumn(
              columnName: 'transaction_cat_id', dataType: DataType.integer),
          DatabaseColumn(
              columnName: 'transaction_type_name', dataType: DataType.text),
          DatabaseColumn(
              columnName: 'transaction_type_color', dataType: DataType.text),
          DatabaseColumn(
              columnName: 'transaction_type_icon', dataType: DataType.text),
          DatabaseColumn(
              columnName: 'transaction_type_description',
              dataType: DataType.text),
          DatabaseColumn(columnName: 'is_active', dataType: DataType.integer),
        ],
        foreignKey: DatabaseForeignKey(
            'transaction_cat_id', transactionCategoryTable.tableName));

    String _createTransactionType =
        DatabaseNamingHelper.getCreateTableString(transactionTypeTable);

    stderr.write(_createTransactionType);

    expect(_createTransactionType,
        'CREATE TABLE transaction_type (id INTEGER PRIMARY KEY, transaction_cat_id INTEGER, transaction_type_name TEXT, transaction_type_color TEXT, transaction_type_icon TEXT, transaction_type_description TEXT, is_active INTEGER, FOREIGN KEY(transaction_cat_id) REFERENCES transaction_cat(id));');
  });

  test('raw insert query created: ', () {
    final DatabaseTable transactionCategoryTable =
        DatabaseTable(tableName: 'transaction_cat', columns: [
      DatabaseColumn(isIdColumn: true),
      DatabaseColumn(
          columnName: 'transaction_cat_name', dataType: DataType.text)
    ]);

      List<DatabaseColumn> columns = transactionCategoryTable.columns;
      String insertSql = '';
      for (var c in transactionCategories) {
        insertSql += '''
        INSERT INTO ${transactionCategoryTable.tableName}
        (${columns[0]}, ${columns[1]})
        VALUES (
          ${c.transactionCategoryId}, ${c.transactionCategoryName}
        ); 
      ''';
      }

      stderr.write(insertSql);
    }
  );
}
