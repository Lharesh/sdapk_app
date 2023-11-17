import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sdapk_app/appointments/Calendar/day_view_widget.dart';
import 'package:sdapk_app/utilities/home_screen.dart';


class AppointmentsScreen extends ConsumerStatefulWidget {
  const AppointmentsScreen({Key?  key, required this.createAppointment}): super(key: key);
  final VoidCallback? createAppointment;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends ConsumerState<AppointmentsScreen> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: const  Center(
        child:
        // Text(
        //   'No Appointments To Display.',
        //   style: TextStyle(
        //       color: Colors.blue,
        //       fontWeight: FontWeight.bold,
        //       fontSize: 20),
        // ),
        DayViewWidget()
      ),

      floatingActionButton: FloatingActionButton(
        // onPressed: () {
        //   widget.createAppointment!();
        // },
        onPressed: () async {
          // final event =
          // await context.pushRoute<CalendarEventData<Event>>(CreateEventPage(
          //   withDuration: true,
          // ));
          // if (event == null) return;
          // CalendarControllerProvider.of<Event>(context).controller.add(event);
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
