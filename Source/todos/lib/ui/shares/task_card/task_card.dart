/// https://stackoverflow.com/questions/62207592/flutter-how-to-auto-resize-height-width-fontsize-in-listview-based-on-expande
/// https://stackoverflow.com/questions/52659759/how-can-i-get-the-size-of-the-text-widget-in-flutter/52991124#52991124
/// https://www.programmersought.com/article/53486720020/
/// https://stackoverflow.com/questions/56814744/how-can-i-get-width-and-height-of-text

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../base/base.dart';
import '../../../core/core.dart';
import '../../../ui/ui.dart';

import 'task_card_event.dart';
import 'task_card_controller.dart';

class TaskCard extends StatelessWidget {
  final double? height;
  final double spacing;
  final VoidCallback? onPressed;
  final VoidCallback? onDeleted;

  const TaskCard({
    Key? key,
    this.height,
    this.spacing = 0,
    this.onPressed,
    this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaskCardController controller = Provider.of<TaskCardController>(context);

    return StreamProvider<Task>.value(
      value: controller.taskStream,
      initialData: controller.task,
      child: Consumer<Task>(
        builder: (context, task, child) {
          return GestureDetector(
            onTap: this.onPressed,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: this.spacing,
                ),
                Container(
                  padding: EdgeInsets.only(top: 12, left: 30, bottom: 12, right: 10),
                  // height: this.height,
                  decoration: BoxDecoration(
                    color: task.isDone ? AppColors.background : AppColors.white,
                    shape: BoxShape.rectangle,
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        task.isDone ? Icons.check_box_outlined : Icons.check_box_outline_blank_rounded,
                        size: 18,
                        color: task.isDone ? AppColors.cancel : AppColors.greyText,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${task.title}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: (task.isDone) ? AppColors.cancel : AppColors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decorationColor: (task.isDone) ? AppColors.cancel : AppColors.clear,
                                decorationStyle: TextDecorationStyle.solid,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            if (task.endTime != null)
                              SizedBox(
                                height: 4,
                              ),
                            if (task.endTime != null)
                              Text(
                                '${task.timeString}',
                                style: TextStyle(
                                  color: AppColors.greyText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Button(
                        icon: Icons.delete,
                        iconSize: Size(24, 24),
                        color: AppColors.greyText,
                        width: 32,
                        height: 32,
                        onPressed: this.onDeleted,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
