import 'package:employee/components/common_button.dart';
import 'package:employee/constants/common_colors.dart';
import 'package:employee/helper/calendar_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    super.key,
    required this.dateMap,
    required this.reverseDateMap,
  });

  final Map<DateTime, String> dateMap;
  final Map<String, DateTime> reverseDateMap;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime _selectedDay = DateTime.now().onlyDate;
  DateTime _focusedDay = DateTime.now().onlyDate;

  void setDate(DateTime date) {
    setState(() {
      _selectedDay = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CommonColors.whiteColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: CommonButton(
                    onPressed: () =>
                        setDate(widget.reverseDateMap[CalendarHelper.today]!),
                    backgroundColor:
                        widget.dateMap[_selectedDay] != CalendarHelper.today
                            ? CommonColors.lightBlueColor
                            : CommonColors.blueColor,
                    textColor:
                        widget.dateMap[_selectedDay] != CalendarHelper.today
                            ? CommonColors.blueColor
                            : CommonColors.whiteColor,
                    labelText: CalendarHelper.today,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: CommonButton(
                    onPressed: () => setDate(
                      widget.reverseDateMap[CalendarHelper.nextMonday]!,
                    ),
                    backgroundColor: widget.dateMap[_selectedDay] !=
                            CalendarHelper.nextMonday
                        ? CommonColors.lightBlueColor
                        : CommonColors.blueColor,
                    textColor: widget.dateMap[_selectedDay] !=
                            CalendarHelper.nextMonday
                        ? CommonColors.blueColor
                        : CommonColors.whiteColor,
                    labelText: CalendarHelper.nextMonday,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: CommonButton(
                    onPressed: () => setDate(
                        widget.reverseDateMap[CalendarHelper.nextTuesday]!),
                    backgroundColor: widget.dateMap[_selectedDay] !=
                            CalendarHelper.nextTuesday
                        ? CommonColors.lightBlueColor
                        : CommonColors.blueColor,
                    textColor: widget.dateMap[_selectedDay] !=
                            CalendarHelper.nextTuesday
                        ? CommonColors.blueColor
                        : CommonColors.whiteColor,
                    labelText: CalendarHelper.nextTuesday,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: CommonButton(
                    onPressed: () => setDate(
                        widget.reverseDateMap[CalendarHelper.after1Week]!),
                    backgroundColor: widget.dateMap[_selectedDay] !=
                            CalendarHelper.after1Week
                        ? CommonColors.lightBlueColor
                        : CommonColors.blueColor,
                    textColor: widget.dateMap[_selectedDay] !=
                            CalendarHelper.after1Week
                        ? CommonColors.blueColor
                        : CommonColors.whiteColor,
                    labelText: CalendarHelper.after1Week,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              calendarBuilders: CalendarBuilders(
                selectedBuilder: (context, date, _) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: CommonColors.blueColor,
                        ),
                        color: CommonColors.blueColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        date.day.toString(),
                        style: const TextStyle(
                          color: CommonColors.whiteColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                },
                todayBuilder: (context, date, _) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: CommonColors.blueColor,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        date.day.toString(),
                        style: const TextStyle(
                          color: CommonColors.blueColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                },
                defaultBuilder: (context, day, focusedDay) => Text(
                  day.day.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              calendarStyle: const CalendarStyle(
                outsideDaysVisible: false,
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
              ),
            ),
          ),
          const Divider(
            color: CommonColors.borderColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: CommonColors.blueColor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      DateFormat('d MMM, yyyy').format(_selectedDay),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CommonButton(
                      backgroundColor: CommonColors.lightBlueColor,
                      labelText: 'Cancel',
                      textColor: CommonColors.blueColor,
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    CommonButton(
                      backgroundColor: CommonColors.blueColor,
                      labelText: 'Save',
                      textColor: CommonColors.whiteColor,
                      onPressed: () =>
                          Navigator.pop(context, _selectedDay.onlyDate),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
