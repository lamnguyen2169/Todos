///

import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'database_operators.dart';
import 'database_schema.dart';

class DatabaseManager {
  static const int databaseVersion = 1;

  static const _createScripts = [DatabaseSchema.tableTaskCreate];
  static const _upgradeScripts = [];

  static late Database _database;

  /// Singleton
  DatabaseManager._();

  static final DatabaseManager instance = DatabaseManager._();

  /// MARK: - Getter/Setter

  /// MARK: - Local methods
  /// Executes a raw SQL SELECT query and returns a list
  /// of the rows that were found.
  ///
  /// ```
  /// List<Map> list = await database.rawQuery('SELECT * FROM Test');
  /// ```
  static Future<List<Map<String, Object?>>> _select(String sql, [List<Object?>? arguments]) async =>
      _database.rawQuery(sql, arguments);

  /// Executes a raw SQL INSERT query and returns the last inserted row ID.
  ///
  /// ```
  /// int id1 = await database.rawInsert(
  ///   'INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
  /// ```
  ///
  /// 0 could be returned for some specific conflict algorithms if not inserted.
  static Future<int> _insert(String sql, [List<Object?>? arguments]) async => _database.rawInsert(sql, arguments);

  /// Executes a raw SQL UPDATE query and returns
  /// the number of changes made.
  ///
  /// ```
  /// int count = await database.rawUpdate(
  ///   'UPDATE Test SET name = ?, value = ? WHERE name = ?',
  ///   ['updated name', '9876', 'some name']);
  /// ```
  static Future<int> _update(String sql, [List<Object?>? arguments]) async => _database.rawUpdate(sql, arguments);

  /// Executes a raw SQL DELETE query and returns the
  /// number of changes made.
  ///
  /// ```
  /// int count = await database
  ///   .rawDelete('DELETE FROM Test WHERE name = ?', ['another name']);
  /// ```
  static Future<int> _delete(String sql, [List<Object?>? arguments]) async => _database.rawDelete(sql, arguments);

  /// MARK: - Public methods
  static Future<Database> startup() async {
    final Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, DatabaseSchema.name);

    print('startup - path=$path');

    _database = await openDatabase(
      path,
      onCreate: (database, version) {
        _createScripts.forEach((element) async {
          await database.execute(element);
        });
      },
      onUpgrade: (database, oldVersion, version) {
        _upgradeScripts.forEach((element) async {
          await database.execute(element);
        });
      },
      version: databaseVersion,
    );

    return _database;
  }

  static Future<dynamic> executeQuery(
    String sql, {
    List<Object?>? arguments,
  }) async {
    sql = sql.trim();
    final String operator = sql.split(' ').first;

    switch (operator) {
      case DatabaseOperators.select:
        return _select(sql, arguments);
      case DatabaseOperators.insert:
        return _insert(sql, arguments);
      case DatabaseOperators.update:
        return _update(sql, arguments);
      case DatabaseOperators.delete:
        return _delete(sql, arguments);
      default:
        throw Exception('Invalid SQL query');
    }
  }
}
