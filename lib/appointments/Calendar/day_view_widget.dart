import 'dart:ffi';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:sdapk_app/patients/models/event.dart';

DateTime get _now => DateTime.now();

class DayViewPage extends StatefulWidget {

  final GlobalKey<DayViewState>? state;
   final double? width;

  const DayViewPage({Key? key, this.state, this.width}) : super(key: key);


  @override
  DayViewWidget createState() => DayViewWidget(state, width);
}


class DayViewWidget extends State<DayViewPage> {
  // final GlobalKey<DayViewState>? state;
  //  final double? width;

  //  DayViewWidget({
  //   Key? key,
  //   this.state,
  //   this.width,
  // }) : super(key: key);

  DayViewWidget(this.state,this.width);

   GlobalKey<DayViewState>? state;
   double? width;

  String dropdownValue = 'Hours';
  bool isHour = true;
  bool isHalfHour = false;
  bool isQuaterHour = false;
  bool isOneAndHalfHour = false;

  List<String> listVal = ['Hours', 'Half Hours', 'Quater Hours', 'One And HalfHours'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      dropdownValue = 'Hours';
      isHour = true;
      isHalfHour = false;
      isQuaterHour = false;
      isOneAndHalfHour = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
        controller: EventController<Event>()..addAll(_events),
        child:
        Column(
          // mainAxisSize: MainAxisSize.min,
          children: <Widget> [

            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                height: 40,
                child: Center(
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 10),
                      Text("Select Duration:"),
                      SizedBox(width: 4),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     print("press button");
                      //   },
                      //   child: Text("Half Hour"),
                      // ),
                      DropdownButton<String>(
                        // Step 3.
                        value: dropdownValue,
                        // Step 4.
                        items: listVal
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child:Text(
                                value,
                                textAlign: TextAlign.center,
                                // style: TextStyle(fontSize: 30),
                              ),
                            )
                          );
                        }).toList(),
                        // Step 5.
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                            //['Hours', 'Half Hours', 'Quater Hours', 'One And HalfHours']
                            if(dropdownValue == "Hours"){
                              this.isHour = true;
                              this.isHalfHour = false;
                              this.isQuaterHour = false;
                              this.isOneAndHalfHour = false;
                            } else if(dropdownValue == "Half Hours"){
                              this.isHour = true;
                              this.isHalfHour = true;
                              this.isQuaterHour = false;
                              this.isOneAndHalfHour = false;
                            } else if(dropdownValue == "Quater Hours"){
                              this.isHour = true;
                              this.isHalfHour = true;
                              this.isQuaterHour = true;
                              this.isOneAndHalfHour = false;
                            } else if(dropdownValue == "One And HalfHours"){
                              this.isHour = false;
                              this.isHalfHour = false;
                              this.isQuaterHour = false;
                              this.isOneAndHalfHour = true;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                )
            ),
            ),
            Expanded(
              flex: 9,
                child: Container(
                  alignment: Alignment.center,
                  child: DayView<Event>(
                    key: state,
                    width: width,
                    startDuration: Duration(hours: 8),
                    showHours: isHour,
                    showVerticalLine: true,
                    showHalfHours: isHalfHour,
                    showQuaterHours: isQuaterHour,
                    showHourAndHalfHours: isOneAndHalfHour,
                    showLiveTimeLineInAllDays: true,
                    heightPerMinute: 3,
                    minuteSlotSize: MinuteSlotSize.minutes30,
                    timeLineBuilder: _timeLineBuilder,
                    hourIndicatorSettings: HourIndicatorSettings(
                      color: Theme.of(context).dividerColor,
                    ),
                    halfHourIndicatorSettings: HourIndicatorSettings(
                      color: Theme.of(context).dividerColor,
                      // lineStyle: LineStyle.dashed,
                    ),
                    quaterHourIndicatorSettings: HourIndicatorSettings(
                      color: Theme.of(context).dividerColor,
                      // lineStyle: LineStyle.dashed,
                    ),
                  ),
                )
            ),
          ],
        ),
    );

  }

  Widget _timeLineBuilder(DateTime date) {
    if (date.minute != 0) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            top: -8,
            right: 8,
            child: Text(
              "${date.hour}:${date.minute}",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black.withAlpha(50),
                fontStyle: FontStyle.italic,
                fontSize: 12,
              ),
            ),
          ),
        ],
      );
    }

    final hour = ((date.hour - 1) % 12) + 1;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          top: -8,
          right: 8,
          child: Text(
            "$hour ${date.hour ~/ 12 == 0 ? "am" : "pm"}",
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

List<CalendarEventData<Event>> _events = [];
/* List<CalendarEventData<Event>> _events = [
  CalendarEventData(
    date: _now,
    event: Event(title: "Joe's Birthday"),
    title: "Project meeting",
    description: "Today is project meeting.",
    startTime: DateTime(_now.year, _now.month, _now.day, 18, 30),
    endTime: DateTime(_now.year, _now.month, _now.day, 22),
  ),
  CalendarEventData(
    date: _now.add(Duration(days: 1)),
    startTime: DateTime(_now.year, _now.month, _now.day, 18),
    endTime: DateTime(_now.year, _now.month, _now.day, 19),
    event: Event(title: "Wedding anniversary"),
    title: "Wedding anniversary",
    description: "Attend uncle's wedding anniversary.",
  ),
  CalendarEventData(
    date: _now,
    startTime: DateTime(_now.year, _now.month, _now.day, 14),
    endTime: DateTime(_now.year, _now.month, _now.day, 17),
    event: Event(title: "Football Tournament"),
    title: "Football Tournament",
    description: "Go to football tournament.",
  ),
  CalendarEventData(
    date: _now.add(Duration(days: 3)),
    startTime: DateTime(_now.add(Duration(days: 3)).year,
        _now.add(Duration(days: 3)).month, _now.add(Duration(days: 3)).day, 10),
    endTime: DateTime(_now.add(Duration(days: 3)).year,
        _now.add(Duration(days: 3)).month, _now.add(Duration(days: 3)).day, 14),
    event: Event(title: "Sprint Meeting."),
    title: "Sprint Meeting.",
    description: "Last day of project submission for last year.",
  ),
  CalendarEventData(
    date: _now.subtract(Duration(days: 2)),
    startTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        14),
    endTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        16),
    event: Event(title: "Team Meeting"),
    title: "Team Meeting",
    description: "Team Meeting",
  ),
  CalendarEventData(
    date: _now.subtract(Duration(days: 2)),
    startTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        10),
    endTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        12),
    event: Event(title: "Chemistry Viva"),
    title: "Chemistry Viva",
    description: "Today is Joe's birthday.",
  ),
]; */