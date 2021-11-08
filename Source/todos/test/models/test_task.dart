///

import 'package:flutter_test/flutter_test.dart';
import 'package:todos/core/models/models.dart';

void main() {
  group('Test Task', () {
    final DateTime creationTime = DateTime.now();
    final Task task = Task(
      title: 'Title test 1',
      creationTime: creationTime,
      updateTime: creationTime,
    );

    test('Test Task done', () {
      task.done();

      /// successful
      expect(task.isDone, true);

      /// failed
      /// expect(task.isDone, false);
    });

    test('Test Task undone', () {
      task.undone();

      /// successful
      expect(task.isDone, false);

      /// failed
      /// expect(task.isDone, true);
    });
  });
}
