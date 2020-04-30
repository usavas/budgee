// Open the database and store the reference.
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../repositories/predefined_transaction_types_and_cats.dart';
import 'database_naming_helper.dart';

class DatabaseHelper {
  static final _dbName = 'expenses.db';
  static final _dbVersion = 111;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;

  //singleton design pattern syntax in dart
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  /// open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _dbVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future _onUpgrade(Database db, int upgrade, int downGrade) async {
    //implement onUpgrade code (when updating the application)
  }

  Future _onCreate(Database db, int version) async {
    // table creation
    await db.execute(
        DatabaseNamingHelper.getCreateTableString(transactionCategoryTable));
    await db.execute(
        DatabaseNamingHelper.getCreateTableString(transactionTypeTable));
    await db.execute(
        DatabaseNamingHelper.getCreateTableString(transactionInfoTable));

    // table population
    await db.rawInsert(_populateTransactionCategorySql());
    await db.rawInsert(_populateTransactionTypeSql());
  }

  static final DatabaseTable transactionCategoryTable =
      DatabaseTable(tableName: 'transaction_cat', columns: [
    DatabaseColumn(columnName: 'id', isIdColumn: true),
    DatabaseColumn(columnName: 'transaction_cat_name', dataType: DataType.text)
  ]);

  static final DatabaseTable transactionTypeTable = DatabaseTable(
      tableName: 'transaction_type',
      columns: [
        DatabaseColumn(columnName: 'id', isIdColumn: true),
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

  static final DatabaseTable transactionInfoTable = DatabaseTable(
    tableName: 'transaction_info',
    columns: [
      DatabaseColumn(columnName: 'id', isIdColumn: true),
      DatabaseColumn(
          columnName: 'transaction_type_id', dataType: DataType.integer),
      DatabaseColumn(
          columnName: 'transaction_amount', dataType: DataType.money),
      DatabaseColumn(columnName: 'transaction_note', dataType: DataType.text),
      DatabaseColumn(
          columnName: 'transaction_date', dataType: DataType.dateTime),
    ],
    foreignKey: DatabaseForeignKey(
        'transaction_type_id', transactionTypeTable.tableName),
  );

  
  String _populateTransactionCategorySql() {
    List<DatabaseColumn> columns = transactionCategoryTable.columns;
    String insertSql = 'INSERT INTO ${transactionCategoryTable.tableName} (${columns[0].columnName}, ${columns[1].columnName}) VALUES';
    for (var c in transactionCategories) {
      insertSql += " (${c.transactionCategoryId}, '${c.transactionCategoryName}'), ";
    }
    insertSql = insertSql.substring(0, insertSql.length - 2) + ';';
    return insertSql;
  }

  String _populateTransactionTypeSql() {
    List<DatabaseColumn> columns = transactionTypeTable.columns;
    String insertSql = '''
    INSERT INTO ${transactionTypeTable.tableName} 
    (${columns[0].columnName}, 
      ${columns[1].columnName}, 
      ${columns[2].columnName}, 
      ${columns[3].columnName}, 
      ${columns[4].columnName}, 
      ${columns[5].columnName},
       ${columns[6].columnName}) VALUES 
    ''';
    for (var t in incomeTypes) {
      insertSql += '''
        (${t.transactionTypeId}, ${t.transactionCategoryId}, 
        '${t.transactionTypeName}', '${t.transactionTypeColor}', 
        '${t.transactionTypeIcon}', '${t.transactionTypeDescription}', 
        ${t.isActive ? 1 : 0}), ''';
    }
    for (var t in expenseTypes) {
      insertSql += '''
        (${t.transactionTypeId}, ${t.transactionCategoryId}, 
        '${t.transactionTypeName}', '${t.transactionTypeColor}', 
        '${t.transactionTypeIcon}', '${t.transactionTypeDescription}', 
        ${t.isActive ? 1 : 0}), ''';
    }
    insertSql = insertSql.substring(0, insertSql.length - 2) + ';';
    return insertSql;
  }
}
