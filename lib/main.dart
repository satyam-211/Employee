import 'package:employee/app_router.dart';
import 'package:employee/constants/common_colors.dart';
import 'package:employee/constants/route_constants.dart';
import 'package:employee/data/employee_database_helper.dart';
import 'package:employee/data/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeAdapter());
  await EmployeeDatabaseHelper().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee App',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: CommonColors.blueColor),
          useMaterial3: true,
          fontFamily: 'Roboto'),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: RouteConstants.listEmployee,
    );
  }
}
