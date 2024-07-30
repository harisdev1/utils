// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class ScheduleScreen extends StatefulWidget {
//   const ScheduleScreen({super.key});
//
//   @override
//   ScheduleScreenState createState() => ScheduleScreenState();
// }
//
// class ScheduleScreenState extends State<ScheduleScreen> {
//   DateTime selectedDate = DateTime.now();
//   int selectedWeek = 1;
//
//   int _calculateWeeksInMonth(DateTime date) {
//     final firstDayOfMonth = DateTime(date.year, date.month, 1);
//     final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
//     final firstMonday = firstDayOfMonth.weekday == DateTime.monday
//         ? firstDayOfMonth
//         : firstDayOfMonth.add(
//         Duration(days: (DateTime.monday - firstDayOfMonth.weekday) % 7));
//
//     final totalDays = lastDayOfMonth.difference(firstMonday).inDays + 1;
//     return (totalDays / 7).ceil();
//   }
//
//   DateTime _getFirstDayOfWeek(DateTime date, int weekNumber) {
//     final firstDayOfMonth = DateTime(date.year, date.month, 1);
//     final firstMonday = firstDayOfMonth.weekday == DateTime.monday
//         ? firstDayOfMonth
//         : firstDayOfMonth.add(
//         Duration(days: (DateTime.monday - firstDayOfMonth.weekday) % 7));
//
//     return firstMonday.add(Duration(days: (weekNumber - 1) * 7));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     int weeksInMonth = _calculateWeeksInMonth(selectedDate);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Schedule"),
//       ),
//       body: Column(
//         children: [
//           // Month Selector
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.chevron_left),
//                   onPressed: () {
//                     setState(() {
//                       selectedDate =
//                           DateTime(selectedDate.year, selectedDate.month - 1);
//                       selectedWeek = 1; // Reset to first week of new month
//                     });
//                   },
//                 ),
//                 Text(
//                   DateFormat.yMMM().format(selectedDate),
//                   style: const TextStyle(
//                       fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.chevron_right),
//                   onPressed: () {
//                     setState(() {
//                       selectedDate =
//                           DateTime(selectedDate.year, selectedDate.month + 1);
//                       selectedWeek = 1; // Reset to first week of new month
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//           // Week Selector
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: List.generate(weeksInMonth, (index) {
//                 int week = index + 1;
//                 return ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       selectedWeek = week;
//                     });
//                   },
//                   style: ElevatedButton.styleFrom(
//                     primary: selectedWeek == week ? Colors.blue : Colors.grey,
//                   ),
//                   child: Text('Week $week'),
//                 );
//               }),
//             ),
//           ),
//           // Day Selector
//           Expanded(
//             child: GridView.count(
//               crossAxisCount: 7,
//               children: List.generate(7, (index) {
//                 DateTime firstDayOfWeek =
//                 _getFirstDayOfWeek(selectedDate, selectedWeek);
//                 DateTime day = firstDayOfWeek.add(Duration(days: index));
//
//                 // Ensure the day is within the current month
//                 if (day.month != selectedDate.month) {
//                   return Center(
//                     child: Text(""),
//                   );
//                 }
//
//                 return Center(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         DateFormat.E().format(day),
//                         style: const TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         DateFormat.d().format(day),
//                         style: const TextStyle(fontSize: 14),
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  ScheduleScreenState createState() => ScheduleScreenState();
}

class ScheduleScreenState extends State<ScheduleScreen> {
  DateTime selectedDate = DateTime.now();
  int selectedWeek = 1;

  int _calculateWeeksInMonth(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);

    // Calculate the number of weeks, each week has 7 days
    return ((lastDayOfMonth.day - firstDayOfMonth.day + 1) / 7).ceil();
  }

  DateTime _getFirstDayOfWeek(DateTime date, int weekNumber) {
    // Week number starts from 1, so the first day of the week is calculated
    // by taking the first day of the month and adding (weekNumber - 1) * 7 days.
    return DateTime(date.year, date.month, 1)
        .add(Duration(days: (weekNumber - 1) * 7));
  }

  @override
  Widget build(BuildContext context) {
    int weeksInMonth = _calculateWeeksInMonth(selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule"),
      ),
      body: Column(
        children: [
          // Month Selector
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      selectedDate =
                          DateTime(selectedDate.year, selectedDate.month - 1);
                      selectedWeek = 1; // Reset to first week of new month
                    });
                  },
                ),
                Text(
                  DateFormat.yMMM().format(selectedDate),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      selectedDate =
                          DateTime(selectedDate.year, selectedDate.month + 1);
                      selectedWeek = 1; // Reset to first week of new month
                    });
                  },
                ),
              ],
            ),
          ),
          // Week Selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(weeksInMonth, (index) {
                int week = index + 1;
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedWeek = week;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: selectedWeek == week ? Colors.blue : Colors.grey,
                  ),
                  child: Text('Week $week'),
                );
              }),
            ),
          ),
          // Day Selector
          Expanded(
            child: GridView.count(
              crossAxisCount: 7,
              children: List.generate(7, (index) {
                DateTime firstDayOfWeek =
                    _getFirstDayOfWeek(selectedDate, selectedWeek);
                DateTime day = firstDayOfWeek.add(Duration(days: index));

                // Ensure the day is within the current month
                if (day.month != selectedDate.month) {
                  return Center(
                    child: Text(""),
                  );
                }

                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        DateFormat.E().format(day),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat.d().format(day),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
