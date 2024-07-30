import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sh_app/data/scedule_list.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  ScheduleScreenState createState() => ScheduleScreenState();
}

class ScheduleScreenState extends State<ScheduleScreen> {
  DateTime selectedDate = DateTime.now();
  int selectedWeek = 1;
  DateTime? selectedDay; // Variable to track the selected day

  int _calculateWeeksInMonth(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
    return ((lastDayOfMonth.day - firstDayOfMonth.day + 1) / 7).ceil();
  }

  DateTime _getFirstDayOfWeek(DateTime date, int weekNumber) {
    return DateTime(date.year, date.month, 1)
        .add(Duration(days: (weekNumber - 1) * 7));
  }

  @override
  Widget build(BuildContext context) {
    int weeksInMonth = _calculateWeeksInMonth(selectedDate);

    DateTime firstDayOfWeek = _getFirstDayOfWeek(selectedDate, selectedWeek);

    selectedDay ??= firstDayOfWeek;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule"),
      ),
      body: Column(
        children: [
          // Month Selector
          _monthSelector(),
          // Week Selector
          _weekSelector(weeksInMonth),
          const SizedBox(height: 10),
          _daySelector(firstDayOfWeek),
          // Events ListView
          if (selectedDay != null) ...[
            _schedulesListView(),
          ],
        ],
      ),
    );
  }

  Widget _schedulesListView() {
    return Expanded(
      child: ListView(
        children: getDummyEvents(selectedDay!).map((event) {
          return Container(
            height: 300, // Set a fixed height for each event
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              elevation: 4,
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(event["title"]!,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(event["subtitle"]!),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        // Handle more options
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      event["description"]!,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _daySelector(DateTime firstDayOfWeek) {
    return SizedBox(
      height: 100,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(7, (index) {
            DateTime day = firstDayOfWeek.add(Duration(days: index));

            // Ensure the day is within the current month
            if (day.month != selectedDate.month) {
              return const SizedBox(width: 50);
            }

            bool isSelected =
                selectedDay != null && selectedDay!.isAtSameMomentAs(day);

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedDay = day;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? Colors.pink : null,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DateFormat.E().format(day),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      DateFormat.d().format(day),
                      style: TextStyle(
                        fontSize: 14,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _weekSelector(int weeksInMonth) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.pinkAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 55, // Set a fixed height for the week selector
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Align days to the start
                children: List.generate(weeksInMonth, (index) {
                  int week = index + 1;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedWeek == week
                            ? Colors.pink
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedWeek = week;
                            selectedDay = _getFirstDayOfWeek(selectedDate,
                                week); // Set first day of the new week as selected
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          decoration: BoxDecoration(
                            color: selectedWeek == week
                                ? Colors.pink
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            'Week $week',
                            style: TextStyle(
                              color: selectedWeek == week
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _monthSelector() {
    return Padding(
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
                selectedWeek = 1;
                selectedDay = null; // Reset selected day on month change
              });
            },
          ),
          Text(
            DateFormat.yMMM().format(selectedDate),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              setState(() {
                selectedDate =
                    DateTime(selectedDate.year, selectedDate.month + 1);
                selectedWeek = 1;
                selectedDay = null; // Reset selected day on month change
              });
            },
          ),
        ],
      ),
    );
  }
}
