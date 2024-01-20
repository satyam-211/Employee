import 'package:employee/data/models/employee.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class EmployeeListState {}

class EmployeeListInitial extends EmployeeListState {}

class EmployeeListLoading extends EmployeeListState {}

class EmployeeDeleting extends EmployeeListState {}

class EmployeeDeleted extends EmployeeListState {
  final Employee employee;

  EmployeeDeleted(this.employee);
}

class AddingEmployee extends EmployeeListState {}

class AddedEmployee extends EmployeeListState {}

class EmployeeListLoaded extends EmployeeListState {
  final List<Employee> currentEmployees;
  final List<Employee> previousEmployees;
  EmployeeListLoaded({
    required this.currentEmployees,
    required this.previousEmployees,
  });
}

class EmployeeListError extends EmployeeListState {
  final String message;
  EmployeeListError(this.message);
}
