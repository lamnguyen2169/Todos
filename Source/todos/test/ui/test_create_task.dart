///

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:todos/core/core.dart';
import 'package:todos/ui/ui.dart';
import 'package:todos/screens/home/create_task/create_task.dart';
import 'package:todos/screens/home/create_task/create_task_controller.dart';

void main() {
  testWidgets('Test CreateTaskScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<CreateTaskController>(
          create: (_) => CreateTaskController(),
          child: CreateTaskScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 5));

    final Finder textField = find.byKey(Key('$UITextField.inputTaskTitle'));

    /// successful
    expect(textField, findsOneWidget);

    /// failed
    /// expect(textField, findsNothing);

    await tester.enterText(textField, 'Công việc 1');

    /// successful
    expect(find.text('Công việc 1'), findsOneWidget);

    /// failed
    /// expect(find.text('Công việc 1'), findsNothing);
  });
}
