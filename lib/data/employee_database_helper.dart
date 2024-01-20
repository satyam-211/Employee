import 'package:employee/data/models/employee.dart';
import 'package:hive/hive.dart';

class EmployeeDatabaseHelper {
  static final EmployeeDatabaseHelper _instance = EmployeeDatabaseHelper._internal();
  late Box<Employee> _box;

  // Named private constructor
  EmployeeDatabaseHelper._internal();

  // Factory constructor to return the same instance
  factory EmployeeDatabaseHelper() {
    return _instance;
  }

  // Initializer method to open the box
  Future<void> init() async {
    _box = await Hive.openBox<Employee>('employeeBox');
  }

  // Add a new employee
  Future<void> addEmployee(Employee employee) async {
    await _box.put(employee.id, employee); // Using employee's id as the key
  }

  // Get an employee by id
  Employee? getEmployee(String id) {
    return _box.get(id);
  }

  // Update an employee
  Future<void> updateEmployee(String id, Employee newEmployee) async {
    await _box.put(id, newEmployee);
  }

  // Delete an employee
  Future<void> deleteEmployee(String id) async {
    await _box.delete(id);
  }

  // Get all employees
  List<Employee> getAllEmployees() {
    return _box.values.toList();
  }
}