import 'package:flutter/material.dart';
import '../screens/he_activities.dart';
import '../screens/patients.dart';
import '../constants/route.dart';
import '../screens/home.dart';
import '../screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Myanmar',
      initialRoute: Routes.login,
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        Routes.login: (BuildContext context) => const Login(),
        Routes.home: (BuildContext context) => const Home(),
        Routes.patients: (BuildContext context) => const Patients(),
        Routes.heActivities: (BuildContext context) => const HEActivities(),
      },
    );
  }
}