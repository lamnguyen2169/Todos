///

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todos/core/core.dart';

void main() async {
  /// Stuck here: Cannot start up the database when application is not set up yet.
  TestWidgetsFlutterBinding.ensureInitialized();
  await DatabaseManager.startup();

  group('Test TaskService', () {
    final TaskService taskService = TaskService();
    final DateTime creationTime = DateTime.now();
    final Task task = Task(
      id: 1,
      title: 'Title test 1',
      creationTime: creationTime,
      updateTime: creationTime,
    );

    test('Test fetchTasks function', () async {
      final List<Task> tasks = await taskService.fetchTasks();

      /// successful
      expect((tasks.length == 0), true);

      /// failed
      expect((tasks.length > 0), false);
    });
  });
}
