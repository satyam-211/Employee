import 'package:employee/components/loading_dialog.dart';
import 'package:employee/constants/common_colors.dart';
import 'package:employee/constants/route_constants.dart';
import 'package:employee/constants/svg_assets.dart';
import 'package:employee/cubits/employee_list_cubit.dart';
import 'package:employee/cubits/employee_list_state.dart';
import 'package:employee/data/models/employee.dart';
import 'package:employee/views/employee_list/widgets/employee_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EmployeeListCubit>().fetchEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Employee List',
          style: TextStyle(
            color: CommonColors.whiteColor,
          ),
        ),
        backgroundColor: CommonColors.blueColor,
      ),
      body: BlocConsumer<EmployeeListCubit, EmployeeListState>(
        listener: (context, state) {
          if (state is EmployeeDeleting) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const LoadingDialog(
                title: 'Deleting',
              ),
            );
          } else if (state is EmployeeDeleted) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Employee Data has been deleted'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () =>
                      context.read<EmployeeListCubit>().addEmployee(
                            state.employee,
                          ),
                ),
              ),
            );
          } else if (state is AddingEmployee) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const LoadingDialog(
                title: 'Adding',
              ),
            );
          } else if (state is AddedEmployee) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is EmployeeListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EmployeeListLoaded) {
            if (state.currentEmployees.isEmpty &&
                state.previousEmployees.isEmpty) {
              return Center(
                child: SvgPicture.asset(
                  SvgAssets.noEmployeeFound,
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  EmployeeListWidget(
                    employees: state.currentEmployees,
                    heading: 'Current Employees',
                    onEmployeeTap: onEmployeeTap,
                  ),
                  EmployeeListWidget(
                    employees: state.previousEmployees,
                    heading: 'Previous Employees',
                    onEmployeeTap: onEmployeeTap,
                  ),
                ],
              ),
            );
          } else if (state is EmployeeListError) {
            return Center(child: Text(state.message));
          }
          return Center(
              child: SvgPicture.asset(
            SvgAssets.noEmployeeFound,
          ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onEmployeeTap,
        backgroundColor: CommonColors.blueColor,
        child: const Icon(
          Icons.add,
          color: CommonColors.whiteColor,
        ),
      ),
      bottomNavigationBar: const ColoredBox(
        color: CommonColors.borderColor,
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 30,
            top: 16,
          ),
          child: Text(
            'Swipe left to delete',
            style: TextStyle(
              color: Color(0xFF949C9E),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  void onEmployeeTap({Employee? employee}) {
    Navigator.of(context)
        .pushNamed(RouteConstants.addEmployee, arguments: employee)
        .then(
          (value) => ((value as bool?) ?? false)
              ? context.read<EmployeeListCubit>().fetchEmployees()
              : null,
        );
  }
}
