import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_along/authentication/auth.dart';
import 'package:ride_along/constants/colors.dart';
import 'package:ride_along/constants/routes.dart';
import 'package:ride_along/controllers/main-controller.dart';
import 'package:ride_along/global-states/drawer.dart' as drwer;
import 'package:ride_along/screens/home/home.dart';
import 'package:ride_along/screens/login/login.dart';
import 'package:ride_along/screens/welcome/welcome.dart';
import 'screens/loading/loading.dart';
import 'screens/new-task/new-task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  //MainController mainController = (MainController());
  final String initRoute = loginRoute;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => drwer.DrawerState(),
      child: MaterialApp(
        title: 'Ride Along',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
        ),
        debugShowCheckedModeBanner: false,
        home: Auth(),

        //LoadingScreen(),
        //initialRoute: initRoute,
        // routes: {
        //   loading_route: (context) => LoadingScreen(),
        //   home_route: (context) => HomeScreen(),
        //   welcome_route: (context) => WelcomeScreen(),
        //   newtask_route: (context) => NewTaskScreen(),
        //   loginRoute: (context) => LoginScreen(),
        // },
        //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
