part of 'add_employee_cubit.dart';

@immutable
abstract class AddEmployeeState {}

class AddEmployeeInitial extends AddEmployeeState {}

class AddEmployeeLoading extends AddEmployeeState {}

class DeletingEmployee extends AddEmployeeState {}

class DeletedEmployee extends AddEmployeeState {
  final Employee employee;

  DeletedEmployee(this.employee);
}

class AddEmployeeSuccess extends AddEmployeeState {}

class AddEmployeeError extends AddEmployeeState {
  final String message;
  AddEmployeeError(this.message);
}
