import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:sh_app/utils/utils.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CustomAppointmentWidget extends StatelessWidget {
  final CalendarEventData appointment;

  const CustomAppointmentWidget({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        margin: const EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
        decoration: BoxDecoration(
            //   color: appointment.color,
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 4,
                  offset: Offset(0, 0),
                  color: Colors.black.withOpacity(0.1))
            ]
//           border: Border(
//             left: BorderSide(
// //            color: appointment.color,
//               color: Colors.red,
//               width: 15,
//             ),
//           ),
            ),
        child: Stack(
          children: [
            Positioned(
              bottom: 10,
              right: 10,
              child: Text(getDurationString(
                  appointment.startTime!, appointment.endTime!)),
            ),
            Row(
              children: [
                Container(
                  width: 10,
                  decoration: BoxDecoration(
                      color: appointment.color,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      )),
                ),
                const SizedBox(width: 20),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        appointment.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        appointment.description ?? "",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
