///

import 'dart:async';

import '../database/database.dart';
import '../models/models.dart';

import 'repository.dart';

class TaskRepository extends Repository {
  /// MARK: - Constructors
  TaskRepository();

  /// MARK: - Local methods

  /// MARK: - Public methods
  Future<List<Task>> fetchTasks() async {
    final Completer<List<Task>> completer = Completer<List<Task>>();
    final String tableTask = TableTask.name;
    final String sql = 'SELECT * FROM $tableTask ORDER BY ${TableTask.columnCreationTime} DESC;';

    DatabaseManager.executeQuery(sql).then((value) {
      if (value is List<Map<String, dynamic>>) {
        final List<Task> tasks = value.map((element) => Task.fromDBJson(element)).toList();

        completer.complete(tasks);
      }
    });

    return completer.future;
  }

  Future<List<Task>> fetchUndoneTasks() async {
    final Completer<List<Task>> completer = Completer<List<Task>>();
    final String tableTask = TableTask.name;
    final String sql = 'SELECT * FROM $tableTask WHERE ${TableTask.columnFlag}=? ORDER BY ${TableTask.columnCreationTime} DESC;';
    final List<Object?>? arguments = [0];

    DatabaseManager.executeQuery(sql, arguments: arguments).then((value) {
      if (value is List<Map<String, dynamic>>) {
        final List<Task> tasks = value.map((element) => Task.fromDBJson(element)).toList();

        completer.complete(tasks);
      }
    });

    return completer.future;
  }

  Future<List<Task>> fetchDoneTasks() async {
    final Completer<List<Task>> completer = Completer<List<Task>>();
    final String tableTask = TableTask.name;
    final String sql = 'SELECT * FROM $tableTask WHERE ${TableTask.columnFlag}=? ORDER BY ${TableTask.columnCreationTime} DESC;';
    final List<Object?>? arguments = [1];

    DatabaseManager.executeQuery(sql, arguments: arguments).then((value) {
      if (value is List<Map<String, dynamic>>) {
        final List<Task> tasks = value.map((element) => Task.fromDBJson(element)).toList();

        completer.complete(tasks);
      }
    });

    return completer.future;
  }

  Future<Task?> insertTask(Task task) async {
    final Completer<Task?> completer = Completer<Task?>();
    final String tableTask = TableTask.name;
    final List<MapEntry<String, dynamic>> entries = task.toDBJson().entries.toList();
    final String sql = '''INSERT INTO $tableTask (${entries.map((element) => element.key).join(',')})
    VALUES (${entries.map((element) => '?').join(',')});''';
    final List<Object?>? arguments = [...entries.map((element) => element.value).toList()];

    DatabaseManager.executeQuery(sql, arguments: arguments).then((value) {
      if ((value is int) && (value > 0)) {
        task.id = value;

        completer.complete(task);
        super.objectDidInsert(task);
      } else {
        completer.complete(null);
      }
    });

    return completer.future;
  }

  Future<bool> updateTask(Task task) async {
    final Completer<bool> completer = Completer<bool>();
    final String tableTask = TableTask.name;
    final List<MapEntry<String, dynamic>> entries = task.toDBJson(true).entries.toList();
    final String sql = '''UPDATE $tableTask
    SET ${entries.map((element) => '${element.key}=?').join(',')}
    WHERE ${TableTask.columnID}=?;''';
    final List<Object?>? arguments = [
      ...entries.map((element) => element.value).toList(),
      task.id,
    ];

    DatabaseManager.executeQuery(sql, arguments: arguments).then((value) {
      completer.complete((value is int) && (value > 0));

      if ((value is int) && (value > 0)) {
        super.objectDidUpdate(task, task);
      }
    });

    return completer.future;
  }

  Future<bool> deleteTask(Task task) async {
    final Completer<bool> completer = Completer<bool>();
    final String tableTask = TableTask.name;
    final String sql = 'DELETE FROM $tableTask WHERE ${TableTask.columnID}=?;';
    final List<Object?>? arguments = [task.id];

    DatabaseManager.executeQuery(sql, arguments: arguments).then((value) {
      completer.complete((value is int) && (value > 0));

      if ((value is int) && (value > 0)) {
        super.objectDidDelete(task);
      }
    });

    return completer.future;
  }
}
