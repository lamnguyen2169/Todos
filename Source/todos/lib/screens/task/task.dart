/// https://stackoverflow.com/questions/50551933/display-a-few-words-in-different-colors-in-flutter

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../base/base.dart';
import '../../../core/core.dart';
import '../../../ui/ui.dart';
import '../../../router_controller.dart';

import 'task_event.dart';
import 'task_controller.dart';

/// This class (or a class that this class inherits from) is marked as ‘@immutable’,
/// but one or more of its instance fields aren’t final
/// ignore: must_be_immutable
class TaskScreen extends BaseScreen {
  static const String routeName = '/task';

  TaskScreen({Key? key})
      : super(
          key: key,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          isNavigationChild: true,
        );

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends LifecycleState<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    final TaskController controller = Provider.of<TaskController>(context);

    return BaseContainer(
      left: false,
      bottom: false,
      right: false,
      title: BarTitle(
        title: 'Công việc của tôi',
        fontSize: 26,
        titleAlignment: TextAlign.left,
      ),
      titleSpacing: 16,
      centerTitle: false,
      systemOverlayStyle: this.widget.systemOverlayStyle,
      navigationBarColor: AppColors.white,
      backgroundColor: AppColors.white,
      dependencies: [
        ChangeNotifierProvider<TaskController>.value(
          value: controller,
        ),
      ],
      independences: [],
      child: ContainerWidget(),
    );
  }
}

class ContainerWidget extends StatelessWidget {
  ContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TasksWidget(),
          SizedBox(
            height: 18,
          ),
        ],
      ),
    );
  }
}

class TasksWidget extends StatefulWidget {
  const TasksWidget({Key? key}) : super(key: key);

  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  /// MARK: - override methods

  /// MARK: - Local methods
  void _onTaskPressed(Task task) {
    final TaskController controller = Provider.of<TaskController>(context, listen: false);

    controller.addEvent(TaskEvent(task));
  }

  void _onTaskDeleted(Task task) {
    final TaskController controller = Provider.of<TaskController>(context, listen: false);

    controller.addEvent(TaskDeleteEvent(task));
  }

  /// MARK: - Layout methods
  @override
  Widget build(BuildContext context) {
    final TaskController controller = Provider.of<TaskController>(context);

    return Flexible(
      fit: FlexFit.loose,
      child: Container(
        padding: EdgeInsets.zero,
        child: StreamProvider<List<Task>>.value(
          value: controller.listStream,
          initialData: [],
          updateShouldNotify: (previous, current) => true,
          child: Consumer<List<Task>>(
            builder: (context, tasks, child) {
              return ListView.builder(
                primary: true,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final Task task = tasks[index];
                  final TaskCardController cardController = TaskCardController(task, controller);

                  return ChangeNotifierProvider<TaskCardController>.value(
                    value: cardController,
                    child: TaskCard(
                      key: ObjectKey('${task.id}'),
                      onPressed: () {
                        _onTaskPressed(task);
                      },
                      onDeleted: () {
                        _onTaskDeleted(task);
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
