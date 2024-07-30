import 'package:flutter/material.dart';
import 'package:sh_app/screens/event_screen.dart';
import 'package:sh_app/screens/event_screen_calendar_view.dart';
import 'package:sh_app/screens/schedule_screen.dart';
import 'package:sh_app/utils/scroll_behaviour.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const EventScreen(),
      home: ScheduleScreen(),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child!,
        );
      },
    );
  }
}
