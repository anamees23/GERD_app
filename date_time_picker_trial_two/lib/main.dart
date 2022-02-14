// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//
// void main() => runApp(DateTimePicker());
//
// class DateTimePicker extends StatefulWidget {
//   @override
//   _DateTimePickerState createState() => _DateTimePickerState();
// }
//
// class _DateTimePickerState extends State<DateTimePicker> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomeScreen(),
//     );
//   }
// }
//
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   String _date = "Not set";
//   String _time = "Not set";
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('DateTime Picker'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Container(
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               // ignore: deprecated_member_use
//               RaisedButton(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5.0)),
//                 elevation: 4.0,
//                 onPressed: () {
//                   DatePicker.showDatePicker(context,
//                       theme: DatePickerTheme(
//                         containerHeight: 210.0,
//                       ),
//                       showTitleActions: true,
//                       minTime: DateTime(2022, 1, 1),
//                       maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
//                         print('confirm $date');
//                         _date = '${date.year} - ${date.month} - ${date.day}';
//                         setState(() {});
//                       }, currentTime: DateTime.now(), locale: LocaleType.en);
//                 },
//                 child: Container(
//                   alignment: Alignment.center,
//                   height: 50.0,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           Container(
//                             child: Row(
//                               children: <Widget>[
//                                 Icon(
//                                   Icons.date_range,
//                                   size: 18.0,
//                                   color: Color(0xff379147),
//                                 ),
//                                 Text(
//                                   " $_date",
//                                   style: TextStyle(
//                                       color: Color(0xff379147),
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 18.0),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                       Text(
//                         "  Click to change",
//                         style: TextStyle(
//                             color: Color(0xff379147),
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18.0),
//                       ),
//                     ],
//                   ),
//                 ),
//                 color: Colors.white,
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               // ignore: deprecated_member_use
//               RaisedButton(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5.0)),
//                 elevation: 4.0,
//                 onPressed: () {
//                   DatePicker.showTimePicker(context,
//                       theme: DatePickerTheme(
//                         containerHeight: 210.0,
//                       ),
//                       showTitleActions: true, onConfirm: (time) {
//                         print('confirm $time');
//                         _time = '${time.hour} : ${time.minute}';
//                         setState(() {});
//                       }, currentTime: DateTime.now(), locale: LocaleType.en);
//                   setState(() {});
//                 },
//                 child: Container(
//                   alignment: Alignment.center,
//                   height: 50.0,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           Container(
//                             child: Row(
//                               children: <Widget>[
//                                 Icon(
//                                   Icons.access_time,
//                                   size: 18.0,
//                                   color: Color(0xff379147),
//                                 ),
//                                 Text(
//                                   " $_time",
//                                   style: TextStyle(
//                                       color: Color(0xff379147),
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 18.0),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                       Text(
//                         "  Click to change",
//                         style: TextStyle(
//                             color: Color(0xff379147),
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18.0),
//                       ),
//                     ],
//                   ),
//                 ),
//                 color: Colors.white,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// @override List<int> layoutProportions() => [100, 100, 1];


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
void main()
{
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter TimePicker',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState()
  {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  TimeOfDay selectedTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter TimePicker"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _selectTime(context);
              },
              child: Text("Choose Time"),
            ),
            //Text("${selectedTime.hour}:0${selectedTime.minute}"),
            Text(DateFormat("HH:mm").format(selectedTime.minute),
          ],
        ),
      ),
    );
  }
  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
          context: context,
          initialTime: selectedTime,
          initialEntryMode: TimePickerEntryMode.input,
          confirmText: "CONFIRM",
          cancelText: "NOT NOW",
          helpText: "BOOKING TIME",
    );

    if(timeOfDay != null && timeOfDay != selectedTime)
    {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }
}