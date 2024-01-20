import 'package:employee/constants/route_constants.dart';
import 'package:employee/cubits/add_employee_cubit.dart';
import 'package:employee/cubits/employee_list_cubit.dart';
import 'package:employee/data/models/employee.dart';
import 'package:employee/views/add_employee/add_employee_screen.dart';
import 'package:employee/views/employee_list/employee_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.listEmployee:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => EmployeeListCubit(),
            child: const EmployeeListScreen(),
          ),
        );
      case RouteConstants.addEmployee:
        final employee = settings.arguments as Employee?;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddEmployeeCubit(),
            child: AddEmployeeScreen(
              employee: employee,
            ),
          ),
        );
      // Add other routes here...
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
