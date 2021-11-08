/// https://stackoverflow.com/questions/50551933/display-a-few-words-in-different-colors-in-flutter

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../base/base.dart';
import '../../../core/core.dart';
import '../../../ui/ui.dart';
import '../../../router_controller.dart';

import 'done_task_event.dart';
import 'done_task_controller.dart';

/// This class (or a class that this class inherits from) is marked as ‘@immutable’,
/// but one or more of its instance fields aren’t final
/// ignore: must_be_immutable
class DoneTaskScreen extends BaseScreen {
  static const String routeName = '/done_task';

  DoneTaskScreen({Key? key})
      : super(
          key: key,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          isNavigationChild: true,
        );

  @override
  State<DoneTaskScreen> createState() => _DoneTaskScreenState();
}

class _DoneTaskScreenState extends LifecycleState<DoneTaskScreen> {
  @override
  Widget build(BuildContext context) {
    final DoneTaskController controller = Provider.of<DoneTaskController>(context);

    return BaseContainer(
      left: false,
      bottom: false,
      right: false,
      title: BarTitle(
        title: 'Công việc đã hoàn thành',
        fontSize: 26,
        titleAlignment: TextAlign.left,
      ),
      titleSpacing: 16,
      centerTitle: false,
      systemOverlayStyle: this.widget.systemOverlayStyle,
      navigationBarColor: AppColors.white,
      backgroundColor: AppColors.white,
      dependencies: [
        ChangeNotifierProvider<DoneTaskController>.value(
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
          DoneTasksWidget(),
          SizedBox(
            height: 18,
          ),
        ],
      ),
    );
  }
}

class DoneTasksWidget extends StatefulWidget {
  const DoneTasksWidget({Key? key}) : super(key: key);

  @override
  _DoneTasksWidgetState createState() => _DoneTasksWidgetState();
}

class _DoneTasksWidgetState extends State<DoneTasksWidget> {
  /// MARK: - override methods

  /// MARK: - Local methods
  void _onTaskPressed(Task task) {
    final DoneTaskController controller = Provider.of<DoneTaskController>(context, listen: false);

    controller.addEvent(DoneTaskEvent(task));
  }

  void _onTaskDeleted(Task task) {
    final DoneTaskController controller = Provider.of<DoneTaskController>(context, listen: false);

    controller.addEvent(DoneTaskDeleteEvent(task));
  }

  /// MARK: - Layout methods
  @override
  Widget build(BuildContext context) {
    final DoneTaskController controller = Provider.of<DoneTaskController>(context);

    return Flexible(
      fit: FlexFit.loose,
      child: Container(
        padding: EdgeInsets.zero,
        child: StreamProvider<List<Task>>.value(
          initialData: [],
          value: controller.listStream,
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
