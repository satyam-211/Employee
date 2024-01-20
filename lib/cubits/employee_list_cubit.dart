import 'package:bloc/bloc.dart';
import 'package:employee/cubits/employee_list_state.dart';
import 'package:employee/data/employee_database_helper.dart';
import 'package:employee/data/models/employee.dart';

class EmployeeListCubit extends Cubit<EmployeeListState> {
  EmployeeListCubit() : super(EmployeeListInitial());

  Future<void> fetchEmployees() async {
    try {
      emit(EmployeeListLoading());
      final employees = EmployeeDatabaseHelper().getAllEmployees();
      emit(
        EmployeeListLoaded(
          currentEmployees: employees
              .where((employee) => employee.leaveDate == null)
              .toList(),
          previousEmployees: employees
              .where(
                (employee) => employee.leaveDate != null,
              )
              .toList(),
        ),
      );
    } catch (e) {
      emit(EmployeeListError(e.toString()));
    }
  }

  Future<void> deleteEmployee(Employee employee) async {
    try {
      emit(EmployeeDeleting());
      await EmployeeDatabaseHelper().deleteEmployee(employee.id);
      emit(EmployeeDeleted(employee));
      final employees = EmployeeDatabaseHelper().getAllEmployees();
      emit(
        EmployeeListLoaded(
          currentEmployees: employees
              .where((employee) => employee.leaveDate == null)
              .toList(),
          previousEmployees: employees
              .where((employee) => employee.leaveDate != null)
              .toList(),
        ),
      );
    } catch (e) {
      emit(EmployeeListError(e.toString()));
    }
  }

  Future<void> addEmployee(Employee employee) async {
    try {
      emit(AddingEmployee());
      await EmployeeDatabaseHelper().addEmployee(employee);
      emit(AddedEmployee());
      final employees = EmployeeDatabaseHelper().getAllEmployees();
      emit(
        EmployeeListLoaded(
          currentEmployees: employees
              .where((employee) => employee.leaveDate == null)
              .toList(),
          previousEmployees: employees
              .where((employee) => employee.leaveDate != null)
              .toList(),
        ),
      );
    } catch (e) {
      emit(EmployeeListError(e.toString()));
    }
  }
}
