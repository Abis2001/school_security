
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
   Map<DateTime, String> _events = {
    DateTime(2023, 5, 2): "Happy Diwali",
    DateTime(2023, 4, 30): "Happy EID",
    DateTime(2023, 5,1): "Happy Christmas X",
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: DateTime(2023,5),
      firstDay: DateTime(2000),
      lastDay: DateTime(2025),
       eventLoader: (day) {
        String? event = _events[day];
        if (event != null) {
          return [event];
        } else {
          return [];
        }
      },
      currentDay: DateTime.now(),
      daysOfWeekVisible: true,
      headerVisible: true,
      onCalendarCreated: (pageController) {},
      rangeSelectionMode: RangeSelectionMode.enforced,
      shouldFillViewport: true,
      onDaySelected: (selectedDay, focusedDay) {
        String? event = _events[selectedDay];
        if (event != null) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(selectedDay.toString()),
              content: Text(event),
            ),
          );
        }
      },
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.red,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.redAccent,
        ),
      ),

    );
  }
}