/// https://stackoverflow.com/questions/43928702/how-to-change-the-application-launcher-icon-on-flutter
/// https://stackoverflow.com/questions/51535621/using-navigator-popuntil-and-route-without-fixed-name
/// https://flutter.dev/docs/cookbook/navigation/named-routes
/// https://flutter.dev/docs/cookbook/navigation/navigate-with-arguments

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart';
import 'ui/ui.dart';

import 'router_controller.dart';

class App extends StatefulWidget {
  /// MARK: - Public properties

  /// MARK: - Constructors
  const App({Key? key}) : super(key: key);

  /// MARK: - override methods
  @override
  _AppState createState() => _AppState();

  /// MARK: - Public methods
  static void launch() {
    runApp(
      ChangeNotifierProvider<RouterController>.value(
        value: RouterController.instance,
        child: const App(),
      ),
    );
  }
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    final RouterController controller = Provider.of<RouterController>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: RouterController.instance.navigatorKey,
      title: 'ToDo\'s',
      theme: ThemeData(
        fontFamily: AppFonts.avertaPE,
        primarySwatch: AppColors.main,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ChangeNotifierProvider<NavigationsController>(
              create: (_) => NavigationsController(),
              child: const NavigationsScreen(),
            ),
      },
    );
  }
}
