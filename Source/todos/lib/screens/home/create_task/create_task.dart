/// https://stackoverflow.com/questions/50551933/display-a-few-words-in-different-colors-in-flutter
/// https://stackoverflow.com/questions/57377394/setstate-or-markneedsbuild-called-during-build-on-listview
/// https://stackoverflow.com/questions/47592301/setstate-or-markneedsbuild-called-during-build
/// https://stackoverflow.com/questions/54165549/navigate-to-a-new-screen-in-flutter

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../../base/base.dart';
import '../../../core/core.dart';
import '../../../extensions/extensions.dart';
import '../../../macros/macros.dart';
import '../../../ui/ui.dart';
import '../../../router_controller.dart';

import 'create_task_event.dart';
import 'create_task_controller.dart';

/// This class (or a class that this class inherits from) is marked as ‘@immutable’,
/// but one or more of its instance fields aren’t final
/// ignore: must_be_immutable
class CreateTaskScreen extends BaseScreen {
  static const String routeName = '/home/create_task';

  CreateTaskScreen({Key? key})
      : super(
          key: key,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        );

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends LifecycleState<CreateTaskScreen> {
  /// MARK: - Layout methods
  @override
  Widget build(BuildContext context) {
    final CreateTaskController controller = Provider.of<CreateTaskController>(context);

    return BaseContainer(
      left: false,
      bottom: false,
      right: false,
      systemOverlayStyle: this.widget.systemOverlayStyle,
      backgroundColor: AppColors.white,
      leadingWidget: BarBackButton(
        routeName: CreateTaskScreen.routeName,
      ),
      resizeToAvoidBottomInset: true,
      dependencies: [
        ChangeNotifierProvider<CreateTaskController>.value(
          value: controller,
        ),
      ],
      independences: [],
      child: ContainerWidget(),
      loading: LoadingWidget<CreateTaskController>(),
    );
  }
}

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({Key? key}) : super(key: key);

  /// MARK: - Local methods
  void _handleEventListener(BuildContext context, BaseEvent event) {
    if (event is CreateTaskSuccessEvent) {
      RouterController.pop(CreateTaskScreen.routeName, context);
    } else if (event is CreateTaskFailureEvent) {
      Dialogs.showDelayedWidget(
        context,
        Dialogs.messageWidget(
          context,
          'Cannot create task',
        ),
      );
    }
  }

  /// MARK: - Layout methods
  @override
  Widget build(BuildContext context) {
    return EventListener<CreateTaskController>(
      listener: (event) {
        _handleEventListener(context, event);
      },
      child: Container(
        padding: EdgeInsets.only(left: Constants.margin, right: Constants.margin),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            InputWidget(),
            Spacer(),
            BottomWidget(),
            SizedBox(
              height: 27,
            ),
          ],
        ),
      ),
    );
  }
}

class InputWidget extends StatefulWidget {
  const InputWidget({Key? key}) : super(key: key);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  /// MARK: - Local methods
  void _onDatePressed(BuildContext context) {
    final CreateTaskController controller = Provider.of<CreateTaskController>(context, listen: false);

    Screen.endEditing(context);
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now(),
      onChanged: (date) {},
      onConfirm: (date) {
        controller.dateSink.add(date);
      },
      currentTime: DateTime.now(),
    );
  }

  /// MARK: - Layout methods
  @override
  Widget build(BuildContext context) {
    final CreateTaskController controller = Provider.of<CreateTaskController>(context);
    final TextEditingController inputController = controller.inputController;

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Task you wanna do',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColors.text,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          UITextField(
            key: Key('$UITextField.inputTaskTitle'),
            controller: inputController,
            textAlignVertical: TextAlignVertical.center,
            autofocus: true,
            color: AppColors.text,
            cursorColor: AppColors.text,
            placeholder: 'Input task name',
            placeholderColor: AppColors.greyText,
            fontSize: 16,
            fontWeight: FontWeight.normal,
            backgroundColor: AppColors.background,
            textInputAction: TextInputAction.send,
            height: 50,
            onChanged: (value) {
              controller.inputSink.add(value);
            },
            onEditingComplete: () {},
            onSubmitted: (value) {},
          ),
          SizedBox(
            height: 27,
          ),
          Text(
            'Completion date',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColors.text,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () {
              _onDatePressed(context);
            },
            child: Container(
              padding: EdgeInsets.only(top: 10, left: 15, bottom: 10, right: 15),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(width: 2, color: AppColors.background, style: BorderStyle.solid),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  StreamProvider<DateTime?>.value(
                    value: controller.dateStream,
                    initialData: null,
                    child: Consumer<DateTime?>(
                      builder: (context, date, child) {
                        return Text(
                          '${(date != null) ? date.timeString() : ''}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        );
                      },
                    ),
                  ),
                  Icon(
                    Icons.date_range,
                    size: 20,
                    color: AppColors.greyText,
                  ),
                ],
              ),
            ),
          ),
        ],
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
  void _onCreatePressed(BuildContext context) {
    final CreateTaskController controller = Provider.of<CreateTaskController>(context, listen: false);
    final TextEditingController inputController = controller.inputController;
    final DateTime? endTime = controller.dateStream.valueOrNull;

    Screen.endEditing(context);
    controller.addEvent(CreateTaskEvent(inputController.text, endTime));
  }

  /// MARK: - Layout methods
  @override
  Widget build(BuildContext context) {
    final CreateTaskController controller = Provider.of<CreateTaskController>(context);
    final TextEditingController inputController = controller.inputController;

    return Container(
      child: StreamProvider<bool>.value(
        value: controller.validationStream,
        initialData: false,
        child: Consumer<bool>(
          builder: (context, isEnabled, child) {
            return Button(
              title: 'Create',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              backgroundColor: isEnabled ? AppColors.main : AppColors.disable,
              height: 49,
              onPressed: isEnabled
                  ? () {
                      _onCreatePressed(context);
                    }
                  : null,
            );
          },
        ),
      ),
    );
  }
}
