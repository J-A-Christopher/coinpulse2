import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class IncomeDBHelper {
  //Expenses
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'incomes.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE incomes(id TEXT PRIMARY KEY, title TEXT, amount TEXT, time TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await IncomeDBHelper.database();
    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await IncomeDBHelper.database();
    return db.query(table);
  }

  static Future<int> deleteExpense(String id) async {
    final db = await IncomeDBHelper.database();

    var id1 = await db.delete('incomes', where: 'id = ?', whereArgs: [id]);
    return id1;
  }
  //Incomes
}
