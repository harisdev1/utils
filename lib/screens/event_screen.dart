import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sh_app/data/appointment_list.dart';
import 'package:sh_app/data/calendar_source.dart';
import 'package:sh_app/widgets/event_list_tile.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final ScrollController _timeRulerScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final formattedDate = DateFormat('MMMM d, yyyy').format(currentDate);
    final dayName = DateFormat('EEEE').format(currentDate);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          formattedDate,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _titleDateWidget(dayName),
          const Divider(thickness: 2),
          Expanded(
            child: Row(
              children: [
                //   CustomTimeRuler(scrollController: _timeRulerScrollController),
                Expanded(
                  child: SfCalendar(
                    view: CalendarView.day,
                    showCurrentTimeIndicator: false,
                    //    allowedViews: const [CalendarView.day],
                    headerHeight: 0,
                    dataSource: MyEventDataSource(getDataSource()),
                    viewNavigationMode: ViewNavigationMode.none,
                    todayHighlightColor: Colors.blue,
                    headerStyle: const CalendarHeaderStyle(
                      textStyle: TextStyle(color: Colors.red),
                    ),
                    showWeekNumber: false,
                    viewHeaderHeight: 0,
                    cellEndPadding: 0,
                    //cellBorderColor: Colors.black.withOpacity(0.5),
                    cellBorderColor: Colors.transparent,
                    selectionDecoration: const BoxDecoration(
                      color: Colors.transparent,

                      /// this is to show border of selected cell
                      //  border: Border.all(color: Colors.yellow),
                    ),
                    timeSlotViewSettings: const TimeSlotViewSettings(
                      startHour: 0,
                      endHour: 24,
                      timeInterval: Duration(hours: 1),
                      timeFormat: 'h a',
                      timeIntervalHeight: 45,
                      allDayPanelColor: Colors.red,
                      timeIntervalWidth: -1,
                      timelineAppointmentHeight: 50,

                      ///Change color of slots names i.e 1 AM
                      timeTextStyle: TextStyle(color: Colors.black),
                      // timeRulerSize: 0,
                      timeRulerSize: -1,
                    ),
                    appointmentBuilder:
                        (context, CalendarAppointmentDetails? appointment) {
                      return CustomAppointmentWidget(
                          appointment: appointment?.appointments.first);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.pinkAccent,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onCalendarViewChanged(ViewChangedDetails details) {
    final visibleDates = details.visibleDates;
    if (visibleDates.isNotEmpty) {
      final firstVisibleTime = visibleDates.first;
      final timeInMinutes =
          firstVisibleTime.hour * 60 + firstVisibleTime.minute;
      final scrollPosition =
          (timeInMinutes / 60) * 60; // Calculate scroll position
      _timeRulerScrollController.jumpTo(scrollPosition);
    }
  }

  Align _titleDateWidget(String dayName) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          dayName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CustomTimeRuler extends StatelessWidget {
  final ScrollController scrollController;

  CustomTimeRuler({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50, // Adjust the width as needed
      color: Colors.grey[200], // Background color for the time ruler
      child: ListView.builder(
        controller: scrollController,
        //  physics: NeverScrollableScrollPhysics(), // Attach the scroll controller
        itemCount: 24,
        itemBuilder: (context, index) {
          return Container(
            height: 60, // Height for each hour slot
            alignment: Alignment.center,
            child: Text(
              '${index % 12 == 0 ? 12 : index % 12} ${index < 12 ? 'AM' : 'PM'}',
              style: TextStyle(color: Colors.black),
            ),
          );
        },
      ),
    );
  }
}

class MyEventDataSource extends CalendarDataSource {
  MyEventDataSource(List<Appointment> source) {
    appointments = source;
  }
}
