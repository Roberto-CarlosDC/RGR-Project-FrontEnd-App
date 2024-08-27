// lib/Components/weekly_calendar.dart

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class WeeklyCalendar extends StatelessWidget {
  final DateTime currentDate;
  final Set<DateTime> holidays; // Feriados
  final Map<DateTime, String> noTravelReasons; // Razões para não haver viagens

  WeeklyCalendar({
    required this.currentDate,
    required this.holidays,
    required this.noTravelReasons,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: currentDate,
      firstDay: DateTime.utc(currentDate.year, currentDate.month - 1, 1),
      lastDay: DateTime.utc(currentDate.year, currentDate.month + 1, 0),
      calendarFormat: CalendarFormat.week,
      selectedDayPredicate: (day) => isSameDay(day, currentDate),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
        todayTextStyle: TextStyle(color: Colors.white),
        defaultDecoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Colors.black),
        weekendStyle: TextStyle(color: Colors.black),
      ),
      onDaySelected: (selectedDay, focusedDay) {
        if (noTravelReasons.containsKey(selectedDay)) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Sem Viagem'),
                content: Text(noTravelReasons[selectedDay]!),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      },
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          if (holidays.contains(date)) {
            return Positioned(
              bottom: 1,
              right: 1,
              child: Icon(
                Icons.cancel,
                color: Colors.red,
                size: 20,
              ),
            );
          } else if (isSameDay(date, currentDate)) {
            return Positioned(
              bottom: 1,
              right: 1,
              child: Icon(
                Icons.directions_bus,
                color: Colors.orange,
                size: 20,
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
