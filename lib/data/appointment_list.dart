import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

List<Appointment> getDataSource() {
  final DateTime today = DateTime.now();
  return <Appointment>[
    Appointment(
      startTime: DateTime(today.year, today.month, today.day, 1),
      endTime: DateTime(today.year, today.month, today.day, 3),
      subject: 'Lorem Ipsum dolor',
      notes: "Lorem ipsum dor emt subtitle ",
      color: Colors.pinkAccent,
    ),
    Appointment(
      startTime: DateTime(today.year, today.month, today.day, 4),
      endTime: DateTime(today.year, today.month, today.day, 7),
      subject: 'Lorem Ipsum dolor',
      notes: "Lorem ipsum dor emt subtitle ",
      color: Colors.lightGreen,
    ),
    Appointment(
      startTime: DateTime(today.year, today.month, today.day, 8),
      endTime: DateTime(today.year, today.month, today.day, 10),
      subject: 'Lorem Ipsum dolor',
      notes: "Lorem ipsum dor emt subtitle ",
      color: Colors.deepPurple,
    ),
  ];
}
