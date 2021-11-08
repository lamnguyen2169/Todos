/// https://stackoverflow.com/questions/50551933/display-a-few-words-in-different-colors-in-flutter
/// https://stackoverflow.com/questions/50008737/flutter-corner-radius-with-transparent-background
/// https://cafedev.vn/tu-hoc-flutter-tim-hieu-ve-widget-bottom-navigation-bar-trong-flutter/
/// https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html
/// https://stackoverflow.com/questions/60628943/how-to-push-replacement-removing-whole-navigation-stack-in-flutter
/// https://stackoverflow.com/questions/52598900/flutter-bottomnavigationbar-rebuilds-page-on-change-of-tab

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../base/base.dart';
import '../../ui/ui.dart';
import '../../screens/screens.dart';

import 'navigations_event.dart';
import 'navigations_controller.dart';

class NavigationsScreen extends StatefulWidget {
  static const String routeName = '/navigations';

  const NavigationsScreen({Key? key}) : super(key: key);

  @override
  _NavigationsScreenState createState() => _NavigationsScreenState();
}

class _NavigationsScreenState extends State<NavigationsScreen> {
  /// MARK: - override methods

  /// MARK: - Local methods

  /// MARK: - Layout methods
  @override
  Widget build(BuildContext context) {
    final NavigationsController controller = Provider.of<NavigationsController>(context);
    final double iconSize = 25;
    final double fontSize = 1;

    return StreamProvider<int>.value(
      value: controller.itemStream,
      initialData: 0,
      child: Consumer<int>(
        builder: (context, currentIndex, child) {
          return Scaffold(
            body: Builder(
              builder: (context) => EventListener<NavigationsController>(
                listener: (event) {
                  if (event is DrawerEvent) {
                    Scaffold.of(context).openDrawer();
                  }
                },
                child: IndexedStack(
                  index: currentIndex,
                  children: controller.screens,
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              iconSize: iconSize,
              onTap: (index) {
                controller.addEvent(SelectionEvent(index));
              },
              elevation: 5,
              backgroundColor: AppColors.white,
              selectedFontSize: fontSize,
              unselectedFontSize: fontSize,
              selectedItemColor: AppColors.main,
              unselectedItemColor: AppColors.greyText,
              selectedLabelStyle: TextStyle(
                color: AppColors.main,
                fontSize: fontSize,
                fontWeight: FontWeight.normal,
              ),
              unselectedLabelStyle: TextStyle(
                color: AppColors.greyText,
                fontSize: fontSize,
                fontWeight: FontWeight.normal,
              ),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_rounded,
                    size: iconSize,
                    color: AppColors.greyText,
                  ),
                  activeIcon: Icon(
                    Icons.home_rounded,
                    size: iconSize,
                    color: AppColors.main,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.date_range,
                    size: iconSize,
                    color: AppColors.greyText,
                  ),
                  activeIcon: Icon(
                    Icons.date_range,
                    size: iconSize,
                    color: AppColors.main,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.done_all_sharp,
                    size: iconSize,
                    color: AppColors.greyText,
                  ),
                  activeIcon: Icon(
                    Icons.done_all_sharp,
                    size: iconSize,
                    color: AppColors.main,
                  ),
                  label: '',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
