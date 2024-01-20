import 'package:employee/components/common_button.dart';
import 'package:employee/components/common_textfield.dart';
import 'package:employee/components/loading_dialog.dart';
import 'package:employee/constants/common_colors.dart';
import 'package:employee/cubits/add_employee_cubit.dart';
import 'package:employee/data/models/employee.dart';
import 'package:employee/helper/calendar_helper.dart';
import 'package:employee/views/add_employee/widgets/custom_date_picker.dart';
import 'package:employee/views/add_employee/widgets/role_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({
    super.key,
    this.employee,
  });

  final Employee? employee;

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  late final bool isEditMode;
  late DateTime selectedJoinDate;
  DateTime? selectedLeaveDate;
  final CalendarHelper calendarHelper =
      CalendarHelper(dateTime: DateTime.now().onlyDate);

  late final Employee employee;

  late final TextEditingController nameController;
  late final TextEditingController roleController;
  late final TextEditingController startDayController;
  late final TextEditingController endDayController;

  @override
  void initState() {
    super.initState();
    isEditMode = widget.employee != null;
    employee = widget.employee ?? Employee();
    nameController = TextEditingController(text: widget.employee?.name);
    roleController = TextEditingController(text: widget.employee?.role);
    selectedJoinDate = widget.employee?.joinDate ?? DateTime.now().onlyDate;
    selectedLeaveDate = widget.employee?.leaveDate;
    startDayController = TextEditingController(
      text: calendarHelper.dateMap[selectedJoinDate] ??
          DateFormat('d MMM, yyyy').format(selectedJoinDate),
    );
    endDayController = TextEditingController(
      text: selectedLeaveDate != null
          ? calendarHelper.dateMap[selectedLeaveDate] ??
              DateFormat('d MMM, yyyy').format(selectedLeaveDate!)
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditMode ? 'Edit Employee Details' : 'Add Employee',
          style: const TextStyle(
            color: CommonColors.whiteColor,
          ),
        ),
        iconTheme: const IconThemeData(
          color: CommonColors.whiteColor,
        ),
        backgroundColor: CommonColors.blueColor,
        actions: isEditMode
            ? [
                IconButton(
                  onPressed: () =>
                      context.read<AddEmployeeCubit>().deleteEmployee(employee),
                  icon: const Icon(
                    Icons.delete,
                    color: CommonColors.whiteColor,
                  ),
                ),
              ]
            : null,
      ),
      body: BlocListener<AddEmployeeCubit, AddEmployeeState>(
        listener: (context, state) {
          if (state is AddEmployeeSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'Employee ${!isEditMode ? 'Added' : 'Updated'} Successfully'),
              ),
            );
            Navigator.pop(context, true);
          } else if (state is AddEmployeeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          } else if (state is AddEmployeeLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const LoadingDialog(
                title: 'Saving',
              ),
            );
          } else if (state is DeletingEmployee) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const LoadingDialog(
                title: 'Deleting',
              ),
            );
          } else if (state is DeletedEmployee) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Employee Data has been deleted'),
              ),
            );
            Navigator.pop(context, true);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Form(
            key: _formKey,
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  CommonTextField(
                    prefixWidget: const Icon(
                      Icons.person,
                      color: CommonColors.blueColor,
                    ),
                    hintText: 'Employee Name',
                    controller: nameController,
                    errorText: 'Please enter name',
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  CommonTextField(
                    prefixWidget: const Icon(
                      Icons.work,
                      color: CommonColors.blueColor,
                    ),
                    onTap: _openRoleSheet,
                    hintText: 'Select Role',
                    controller: roleController,
                    suffixWidget: const Icon(
                      Icons.arrow_drop_down_sharp,
                      color: CommonColors.blueColor,
                    ),
                    errorText: 'Please enter role',
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: CommonTextField(
                          onTap: () => _joinDatePicker(),
                          prefixWidget: const Icon(
                            Icons.calendar_month,
                            color: CommonColors.blueColor,
                          ),
                          controller: startDayController,
                          errorText: 'Please enter start date',
                          hintText: 'No date',
                        )),
                        const SizedBox(
                          width: 16,
                        ),
                        const Align(
                          child: Icon(
                            Icons.arrow_right_alt,
                            color: CommonColors.blueColor,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: CommonTextField(
                          onTap: _leaveDatePicker,
                          prefixWidget: const Icon(
                            Icons.calendar_month,
                            color: CommonColors.blueColor,
                          ),
                          controller: endDayController,
                          hintText: 'No date',
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(
          color: CommonColors.borderColor,
        ))),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CommonButton(
                backgroundColor: CommonColors.lightBlueColor,
                labelText: 'Cancel',
                textColor: CommonColors.blueColor,
                onPressed: () {},
              ),
              const SizedBox(
                width: 16,
              ),
              CommonButton(
                backgroundColor: CommonColors.blueColor,
                labelText: 'Save',
                textColor: CommonColors.whiteColor,
                onPressed: _submit,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _openRoleSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const RoleSheet();
      },
    ).then((value) {
      if ((value as String?) != null) {
        roleController.text = value as String;
      }
    });
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      employee.name = nameController.text;
      employee.joinDate = selectedJoinDate;
      employee.leaveDate = selectedLeaveDate;
      employee.role = roleController.text;
      context.read<AddEmployeeCubit>().addEmployee(employee);
    }
  }

  void _joinDatePicker() async {
    final pickedDate = await _openDatePicker();
    if (pickedDate != null) {
      selectedJoinDate = pickedDate;
      startDayController.text = calendarHelper.dateMap[pickedDate] ??
          DateFormat('d MMM, yyyy').format(pickedDate);
    }
  }

  void _leaveDatePicker() async {
    final pickedDate = await _openDatePicker();
    if (pickedDate != null) {
      if (pickedDate.isBefore(selectedJoinDate)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Leave Date cannot be earlier than Join Date'),
          ),
        );
        return;
      }
      selectedLeaveDate = pickedDate;
      endDayController.text = calendarHelper.dateMap[pickedDate] ??
          DateFormat('d MMM, yyyy').format(pickedDate);
    }
  }

  Future<DateTime?> _openDatePicker() {
    return showDialog<DateTime?>(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.93,
          child: CustomDatePicker(
            dateMap: calendarHelper.dateMap,
            reverseDateMap: calendarHelper.reverseDateMap,
          ),
        ),
      ),
    );
  }
}
