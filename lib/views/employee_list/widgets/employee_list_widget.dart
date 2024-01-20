import 'package:employee/constants/common_colors.dart';
import 'package:employee/cubits/employee_list_cubit.dart';
import 'package:employee/data/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EmployeeListWidget extends StatelessWidget {
  const EmployeeListWidget({
    super.key,
    required this.employees,
    required this.heading,
    required this.onEmployeeTap,
  });

  final List<Employee> employees;

  final String heading;

  final void Function({required Employee employee}) onEmployeeTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ColoredBox(
            color: CommonColors.borderColor,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                heading,
                style: const TextStyle(
                  color: CommonColors.blueColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        Flexible(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: employees.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final employee = employees[index];
              return GestureDetector(
                onTap: () => onEmployeeTap(
                  employee: employee,
                ),
                behavior: HitTestBehavior.opaque,
                child: Dismissible(
                  key: ValueKey(employee),
                  onDismissed: (_) => context
                      .read<EmployeeListCubit>()
                      .deleteEmployee(employee),
                  background: const ColoredBox(
                    color: Colors.red,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: 16,
                        ),
                        child: Icon(
                          Icons.delete,
                          color: CommonColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          employee.name,
                          style: const TextStyle(
                            color: Color(0xFF323238),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          employee.role,
                          style: const TextStyle(
                            color: Color(0xFF949C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          employee.leaveDate == null
                              ? 'From ${DateFormat('d MMM, yyyy').format(employee.joinDate)}'
                              : '${DateFormat('d MMM, yyyy').format(employee.joinDate)} - ${DateFormat('d MMM, yyyy').format(employee.leaveDate!)}',
                          style: const TextStyle(
                            color: Color(0xFF949C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
