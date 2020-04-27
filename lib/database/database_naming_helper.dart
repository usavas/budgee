class DatabaseNamingHelper {
  static getCreateTableString(DatabaseTable table) {
    String sql = 'CREATE TABLE ${table.tableName} (';
    for (var col in table.columns) {
      if (col.isIdColumn) {
        sql += '${col.columnName} INTEGER PRIMARY KEY, '; //[AUTOINCREMENT] deleted
      } else {
        var _dType = _getDataType(col.dataType);
        sql += '${col.columnName} $_dType, ';
      }
    }
    if (table.foreignKey != null) {
      sql += 'FOREIGN KEY(${table.foreignKey.foreignKey})' +
          ' REFERENCES ${table.foreignKey.referenceTable}(id), ';
    }
    sql = _trimLastTwoChars(sql);
    sql += ');';
    return sql;
  }
}

String _trimLastTwoChars(String s) {
  return s.substring(0, s.length - 2);
}

class DatabaseTable {
  String tableName;
  List<DatabaseColumn> columns = [];
  DatabaseForeignKey foreignKey;

  DatabaseTable({this.tableName, this.columns, this.foreignKey});
}

class DatabaseColumn {
  bool isIdColumn = false;
  String columnName;
  DataType dataType;

  DatabaseColumn({this.isIdColumn = false, this.columnName, this.dataType});
}

class DatabaseForeignKey {
  String foreignKey;
  String referenceTable;

  DatabaseForeignKey(this.foreignKey, this.referenceTable);
}

_getDataType(DataType t) {
  if (t == DataType.integer) {
    return 'INTEGER';
  } else if (t == DataType.text) {
    return 'TEXT';
  } else if (t == DataType.boolean) {
    return 'INTEGER';
  } else if (t == DataType.dateTime && t == DataType.money) {
    return 'REAL';
  }
}

enum DataType {
  integer,
  text,
  dateTime, //aka REAL
  boolean, //aka INTEGER
  money, //aka REAL
}
