import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:intl/intl.dart';
import 'package:sh_app/widgets/event_list_tile.dart';

class CustomEventCalendarViewScreen extends StatefulWidget {
  const CustomEventCalendarViewScreen({super.key});

  @override
  State<CustomEventCalendarViewScreen> createState() =>
      _CustomEventCalendarViewScreenState();
}

class _CustomEventCalendarViewScreenState
    extends State<CustomEventCalendarViewScreen> {
  final List<CalendarEventData> events = [];
  EventController<Object?> controller = EventController();

  @override
  void initState() {
    final List<CalendarEventData> events = [
      CalendarEventData(
        date: DateTime(2024, 7, 29),
        startTime: DateTime(2024, 7, 29, 1),
        endTime: DateTime(2024, 7, 29, 3),
        title: "Event 1",
        description: "Description of Event 1",
        color: Colors.blue,
      ),
      CalendarEventData(
        date: DateTime(2024, 7, 29),
        startTime: DateTime(2024, 7, 29, 4),
        endTime: DateTime(2024, 7, 29, 7),
        title: "Event 2",
        description: "Description of Event 2",
        color: Colors.green,
      ),
      CalendarEventData(
        date: DateTime(2024, 7, 29),
        startTime: DateTime(2024, 7, 29, 8),
        endTime: DateTime(2024, 7, 29, 10),
        title: "Event 3",
        description: "Description of Event 3",
        color: Colors.red,
      ),
    ];
    controller.addAll(events);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime(2024, 7, 29);
    final formattedDate = DateFormat('MMMM d, yyyy').format(currentDate);
    final dayName = DateFormat('EEEE').format(currentDate);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          formattedDate,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            _titleDateWidget(dayName),
            Divider(thickness: 3, color: Colors.black.withOpacity(0.2)),
            Expanded(
              child: DayView(
                controller: controller,
                // controller:
                eventTileBuilder: (date, events, boundary, start, end) {
                  return Column(
                    children: events.map((event) {
                      //   return CustomEventTile(event: event);
                      return Expanded(
                        child: CustomAppointmentWidget(appointment: event),
                      );
                    }).toList(),
                  );
                },
                fullDayEventBuilder: (events, date) {
                  return Column(
                    children: events.map((event) {
                      //   return CustomEventTile(event: event);
                      return Container(
                        color: Colors.red,
                        width: double.infinity,
                        //height: 50,
                      );
                    }).toList(),
                  );
                },
                // showHalfHours: true,
                showVerticalLine:
                    false, // To display live time line in day view.
                showLiveTimeLineInAllDays:
                    true, // To display live time line in all pages in day view.
                minDay: DateTime(1990),
                maxDay: DateTime(2050),
                initialDay: DateTime(2024, 7, 29),
                heightPerMinute: 0.82, // height occupied by 1 minute time span.
                eventArranger:
                    SideEventArranger(), // To define how simultaneous events will be arranged.
                onEventTap: (events, date) => print(events),
                onEventDoubleTap: (events, date) => print(events),
                onEventLongTap: (events, date) => print(events),
                onDateLongPress: (date) => print(date),
                startHour: 0, // To set the first hour displayed (ex: 05:00)
                dayTitleBuilder: DayHeader.hidden, // To Hide day header
                keepScrollOffset:
                    true, // To maintain scroll offset when the page changes
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleDateWidget(String dayName) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(
          dayName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
