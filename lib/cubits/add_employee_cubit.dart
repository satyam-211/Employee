import 'package:bloc/bloc.dart';
import 'package:employee/data/employee_database_helper.dart';
import 'package:employee/data/models/employee.dart';
import 'package:flutter/foundation.dart';

part 'add_employee_state.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  AddEmployeeCubit() : super(AddEmployeeInitial());

  Future<void> addEmployee(Employee employee) async {
    try {
      emit(AddEmployeeLoading());
      await EmployeeDatabaseHelper().addEmployee(employee);
      emit(AddEmployeeSuccess());
    } catch (e) {
      emit(AddEmployeeError(e.toString()));
    }
  }

  Future<void> deleteEmployee(Employee employee) async {
    try {
      emit(DeletingEmployee());
      await EmployeeDatabaseHelper().deleteEmployee(employee.id);
      emit(DeletedEmployee(employee));
    } catch (e) {
      emit(AddEmployeeError(e.toString()));
    }
  }
}
