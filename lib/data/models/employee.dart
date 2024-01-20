import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'employee.g.dart';

@HiveType(typeId: 0)
class Employee extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String role;

  @HiveField(3)
  late DateTime joinDate;

  @HiveField(4)
  DateTime? leaveDate;

  Employee() {
    id = const Uuid().v4();
  }
}
