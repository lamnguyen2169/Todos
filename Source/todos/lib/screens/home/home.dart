/// https://stackoverflow.com/questions/50551933/display-a-few-words-in-different-colors-in-flutter
/// https://stackoverflow.com/questions/57377394/setstate-or-markneedsbuild-called-during-build-on-listview
/// https://stackoverflow.com/questions/47592301/setstate-or-markneedsbuild-called-during-build
/// https://stackoverflow.com/questions/54165549/navigate-to-a-new-screen-in-flutter
/// https://stackoverflow.com/questions/55611875/ripple-animation-flutter

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../base/base.dart';
import '../../core/core.dart';
import '../../macros/macros.dart';
import '../../ui/ui.dart';
import '../../router_controller.dart';
import 'create_task/create_task.dart' hide ContainerWidget;
import 'create_task/create_task_controller.dart';

import 'home_event.dart';
import 'home_controller.dart';

/// This class (or a class that this class inherits from) is marked as ‘@immutable’,
/// but one or more of its instance fields aren’t final
/// ignore: must_be_immutable
class HomeScreen extends BaseScreen {
  static const String routeName = '/home';

  HomeScreen({Key? key})
      : super(
          key: key,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          isNavigationChild: true,
        );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends LifecycleState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Provider.of<HomeController>(context);

    return BaseContainer(
      left: false,
      bottom: false,
      right: false,
      title: BarTitle(
        title: 'Task List',
        fontSize: 26,
        titleAlignment: TextAlign.left,
      ),
      titleSpacing: 16,
      centerTitle: false,
      systemOverlayStyle: this.widget.systemOverlayStyle,
      navigationBarColor: AppColors.white,
      backgroundColor: AppColors.white,
      dependencies: [
        ChangeNotifierProvider<HomeController>.value(
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
          BottomWidget(),
          SizedBox(
            height: 25,
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
    final HomeController controller = Provider.of<HomeController>(context, listen: false);

    controller.addEvent(HomeEvent(task));
  }

  void _onTaskDeleted(Task task) {
    final HomeController controller = Provider.of<HomeController>(context, listen: false);

    controller.addEvent(HomeDeleteEvent(task));
  }

  /// MARK: - Layout methods
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Provider.of<HomeController>(context);

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

class BottomWidget extends StatefulWidget {
  const BottomWidget({Key? key}) : super(key: key);

  @override
  _BottomWidgetState createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  /// MARK: - Local methods
  void _navigateCreateTaskScreen(BuildContext context) {
    RouterController.push(
      routeName: CreateTaskScreen.routeName,
      context: context,
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<CreateTaskController>(
            create: (_) => CreateTaskController(),
          ),
        ],
        child: CreateTaskScreen(),
      ),
    );
  }

  /// MARK: - Layout methods
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Button(
            icon: Icons.add,
            iconSize: Size(25, 25),
            color: AppColors.white,
            backgroundColor: AppColors.cancel,
            borderRadius: 25,
            shadow: [
              BoxShadow(
                color: AppColors.error,
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ],
            width: 50,
            height: 50,
            onPressed: () {
              _navigateCreateTaskScreen(context);
            },
          ),
        ],
      ),
    );
  }
}
