import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

//import 'LocalNotificationsScreen.dart'
//import 'package:intl/intl.dart';

// Choice #1 for notifications
//import 'package:awesome_notifications/awesome_notifications.dart';
// to store data locally, such as login credentials
// SharedPreferences can be used to store critical data such as passwords,
// tokens, and complex relational data.

import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      //home: LocalNotificationScreen(),
      title: 'Welcome to GERD pH sensor app!',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const PinScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// one-time pin page
class PinScreen extends StatefulWidget {
  const PinScreen({Key? key}) : super(key: key);
  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final PinDelay = 2;

  @override
  void initState() {
    super.initState();
    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: PinDelay);
    return Timer(_duration, checkFirstSeen);
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _introSeen = (prefs.getBool('intro_seen') ?? false);
    //print('oi');
    print(_introSeen);

    if (_introSeen) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Measuring')),
      );
    } else {
      await prefs.setBool('intro_seen', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input your information'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Full Name',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your name',
                ),
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
              const Text(
                'Pin number',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your PIN number',
                ),
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: StadiumBorder(),
                  fixedSize: const Size(240, 80),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SecondScreen()),
                  );
                },
                child: const Text('Continue',
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
            ]
        ),
      ),
    );
  }
}
//end of one-time pin page

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Your current pH measurement is:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              //Use of SizedBox
              height: 10,
            ),
            Text(
              '6.2',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              //Use of SizedBox
              height: 40,
            ),
            const Text(
              'What do you want to record?',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              //Use of SizedBox
              height: 20,
            ),
            Container(
              height: 50.0,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PhyAct()),
                  );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    constraints:
                    BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Physical Activity",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              //Use of SizedBox
              height: 30,
            ),
            Container(
              height: 50.0,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MealInt()),
                  );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xff379147), Color(0xffa8e4a0)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    constraints:
                    BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Meal intake",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              //Use of SizedBox
              height: 30,
            ),
            Container(
              height: 50.0,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Sympt()),
                  );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xfff453a6), Color(0xffdca797)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(
                    constraints:
                    BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Unusual Symptoms",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecondScreen()),
          );
        },
        child: const Icon(Icons.other_houses_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to My GERD Tracker!',
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              //Use of SizedBox
              height: 30,
            ),
            FlatButton(
              onPressed: () {
                // go back to "home page", the appropriate one
                //Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Measuring')),
                );




              },
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.add_chart,
                    size: 80.0,
                  ),
                  Text("Submit Current Status",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ))
                ],
              ),
            ),
            SizedBox(
              //Use of SizedBox
              height: 20,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DataView()),
                );
              },
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.remove_red_eye,
                    size: 80.0,
                  ),
                  Text("View My Data",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ))
                ],
              ),
            ),
            SizedBox(
              //Use of SizedBox
              height: 20,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const getHelp()),
                );
              },
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.person,
                    size: 80.0,
                  ),
                  Text("Ask for Help",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ThirdScreen()),
          );
        },
        child: const Icon(Icons.perm_device_information_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
class getHelp extends StatelessWidget {
  const getHelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask for Help'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Send a message to the doctor',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter the message',
                ),
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
              const Text(
                'Click to add a photo',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),

              // Code to add the photo

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: StadiumBorder(),
                  fixedSize: const Size(240, 80),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AllSet()),
                  );
                },
                child: const Text('Submit',
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: StadiumBorder(),
                  fixedSize: const Size(240, 80),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back',
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
            ]
        ),
      ),
    );
  }
}

class DataView extends StatelessWidget {
  const DataView ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View My Data'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        SizedBox(
        //Use of SizedBox
        height: 30,
      ),
      Container(
        height: 50.0,
        child: RaisedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MealInt()),
            );
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80.0)),
          padding: EdgeInsets.all(0.0),
          child: Ink(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF57F17), Color(0xFFFBC02D)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(30.0)),
            child: Container(
              constraints:
              BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
              alignment: Alignment.center,
              child: Text(
                "Show me my pH data graph",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
        SizedBox(
          //Use of SizedBox
          height: 30,
        ),
        Container(
          height: 50.0,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Sympt()),
              );
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            padding: EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6A1B9A), Color(0xFFCE93D8)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30.0)),
              child: Container(
                constraints:
                BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                alignment: Alignment.center,
                child: Text(
                  "View my current status submissions",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 100),
        ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: StadiumBorder(),
                  fixedSize: const Size(240, 80),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back',
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
        ],
    ),
    ),
    );
  }

}

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instructions'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'To submit your activity status, meal status or to record any unusual symptoms, click on the "Submit Current Status" icon on the home page.',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: StadiumBorder(),
                  fixedSize: const Size(240, 80),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Go to Home Page',
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
            ]
        ),
      ),
    );
  }
}
class PhyAct extends StatelessWidget {
  const PhyAct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Physical Activity'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Activity',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter the activity',
                ),
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),

        //       const Text(
        //         'Time of Activity',
        //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        //         textAlign: TextAlign.center,
        //       ),
        // SizedBox(
        //   //Use of SizedBox
        //   height: 30,
        // ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              shape: StadiumBorder(),
              fixedSize: const Size(240, 80),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreenBlue()),
              );
            },
            child: const Text('Enter Time of Activity',
                style: TextStyle(
                  fontSize: 20,
                )),
        ),
              // Input date and time here
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: StadiumBorder(),
                  fixedSize: const Size(240, 80),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back',
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
            ]
        ),
      ),
    );
  }
}
class MealInt extends StatelessWidget {
  const MealInt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Meal Intake'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Meal',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter the meal',
                ),
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
              // const Text(
              //   'Time of Meal',
              //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              //   textAlign: TextAlign.center,
              // ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: StadiumBorder(),
                  fixedSize: const Size(240, 80),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreenGreen()),
                  );
                },
                child: const Text('Enter Time of Meal',
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),


              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: StadiumBorder(),
                  fixedSize: const Size(240, 80),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back',
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
            ]
        ),
      ),
    );
  }
}
class Sympt extends StatelessWidget {
  const Sympt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Symptoms'),
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Symptom',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter the symptom',
                ),
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
              // const Text(
              //   'Time of start',
              //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              //   textAlign: TextAlign.center,
              //),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink,
                  shape: StadiumBorder(),
                  fixedSize: const Size(240, 80),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreenPink()),
                  );
                },
                child: const Text('Enter Time of Symptom',
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink,
                  shape: StadiumBorder(),
                  fixedSize: const Size(240, 80),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back',
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
            ]
        ),
      ),
    );
  }
}
class AllSet extends StatelessWidget {
  const AllSet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All set!'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'All set! Your information was recorded',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),

              // Code to view the data submitted
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  shape: StadiumBorder(),
                  fixedSize: const Size(240, 80),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SecondScreen()),
                  );
                },
                child: const Text('Back to Home',
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
            ]
        ),
      ),
    );
  }
}

    // class DateTimePicker extends StatefulWidget {
    // @override
    // _DateTimePickerState createState() => _DateTimePickerState();
    // }
    //
    // class _DateTimePickerState extends State<DateTimePicker> {
    // @override
    // Widget build(BuildContext context) {
    // return MaterialApp(
    // debugShowCheckedModeBanner: false,
    // home: HomeScreen(),
    // );
    // }
    // }


    class HomeScreenBlue extends StatefulWidget {
    @override
    _HomeScreenBlueState createState() => _HomeScreenBlueState();
    }

    class _HomeScreenBlueState extends State<HomeScreenBlue> {
    String _date = "Not set";
    String _time = "Not set";

    @override
    void initState() {
    super.initState();
    }

    @override
    Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    title: Text('Select Date and Time'),
    ),
    body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
    child: Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    // ignore: deprecated_member_use
    RaisedButton(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5.0)),
    elevation: 5.0,
    onPressed: () {
    DatePicker.showDatePicker(context,
    theme: DatePickerTheme(
    containerHeight: 210.0,
    ),
    showTitleActions: true,
    minTime: DateTime(2022, 1, 1),
    maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
    print('confirm $date');
    _date = '${date.year} - ${date.month} - ${date.day}';
    setState(() {});
    }, currentTime: DateTime.now(), locale: LocaleType.en);
    },
    child: Container(
    alignment: Alignment.center,
    height: 45.0,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
    Row(
    children: <Widget>[
    Container(
    child: Row(
    children: <Widget>[
    Icon(
    Icons.date_range,
    size: 18.0,
    color: Colors.blue,
    ),
    Text(
    " $_date",
    style: TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
    fontSize: 18.0),
    ),
    ],
    ),
    )
    ],
    ),
    Text(
    "  Click to change",
    style: TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
    fontSize: 18.0),
    ),
    ],
    ),
    ),
    color: Colors.white,
    ),
    SizedBox(
    height: 20.0,
    ),
    // ignore: deprecated_member_use
    RaisedButton(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5.0)),
    elevation: 5.0,
    onPressed: () {
    DatePicker.showTimePicker(context,
    theme: DatePickerTheme(
    containerHeight: 210.0,
    ),
    showTitleActions: true, onConfirm: (time) {
    print('confirm $time');
    _time = '${time.hour} : ${time.minute}';
    setState(() {});
    }, currentTime: DateTime.now(), locale: LocaleType.en);
    setState(() {});
    },
    child: Container(
    alignment: Alignment.center,
    height: 45.0,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
    Row(
    children: <Widget>[
    Container(
    child: Row(
    children: <Widget>[
    Icon(
    Icons.access_time,
    size: 18.0,
    color: Colors.blue,
    ),
    Text(
    " $_time",
    style: TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
    fontSize: 18.0),
    ),
    ],
    ),
    )
    ],
    ),
    Text(
    "  Click to change",
    style: TextStyle(
        color: Colors.blue,
    fontWeight: FontWeight.bold,
    fontSize: 18.0),
    ),
    ],
    ),
    ),
    color: Colors.white,
    ),
      Padding(
        padding: EdgeInsets.only(top: 100),
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
          shape: StadiumBorder(),
          fixedSize: const Size(240, 80),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AllSet()),
          );
        },
        child: const Text('or Currently Doing!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            )),
      ),
      Padding(
        padding: EdgeInsets.only(top: 100),
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          shape: StadiumBorder(),
          fixedSize: const Size(240, 80),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AllSet()),
          );
        },
        child: const Text('Submit',
            style: TextStyle(
              fontSize: 20,
            )),
        )

    ],
    ),
    ),
    ),
    );
    }
    }

  //@override List<int> layoutProportions() => [100, 100, 1];

class HomeScreenGreen extends StatefulWidget {
  @override
  _HomeScreenGreenState createState() => _HomeScreenGreenState();
}

class _HomeScreenGreenState extends State<HomeScreenGreen> {
  String _date = "Not set";
  String _time = "Not set";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Date and Time'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ignore: deprecated_member_use
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 5.0,
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true,
                      minTime: DateTime(2022, 1, 1),
                      maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                        print('confirm $date');
                        _date = '${date.year} - ${date.month} - ${date.day}';
                        setState(() {});
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 45.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  size: 18.0,
                                  color: Colors.green,
                                ),
                                Text(
                                  " $_date",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Click to change",
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              SizedBox(
                height: 20.0,
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 5.0,
                onPressed: () {
                  DatePicker.showTimePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true, onConfirm: (time) {
                        print('confirm $time');
                        _time = '${time.hour} : ${time.minute}';
                        setState(() {});
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 45.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 18.0,
                                  color: Colors.green,
                                ),
                                Text(
                                  " $_time",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Click to change",
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.only(top: 100),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shape: StadiumBorder(),
                  fixedSize: const Size(240, 80),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AllSet()),
                  );
                },
                child: const Text('or Currently Eating/Drinking!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 100),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: StadiumBorder(),
                  fixedSize: const Size(240, 80),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AllSet()),
                  );
                },
                child: const Text('Submit',
                    style: TextStyle(
                      fontSize: 20,
                    )),
              )

            ],
          ),
        ),
      ),
    );
  }
}

//@override List<int> layoutProportions() => [100, 100, 1];

class HomeScreenPink extends StatefulWidget {
  @override
  _HomeScreenPinkState createState() => _HomeScreenPinkState();
}

class _HomeScreenPinkState extends State<HomeScreenPink> {
  String _date = "Not set";
  String _time = "Not set";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Date and Time'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ignore: deprecated_member_use
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 5.0,
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true,
                      minTime: DateTime(2022, 1, 1),
                      maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                        print('confirm $date');
                        _date = '${date.year} - ${date.month} - ${date.day}';
                        setState(() {});
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 45.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  size: 18.0,
                                  color: Colors.pink,
                                ),
                                Text(
                                  " $_date",
                                  style: TextStyle(
                                      color: Colors.pink,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Click to change",
                        style: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              SizedBox(
                height: 20.0,
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 5.0,
                onPressed: () {
                  DatePicker.showTimePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true, onConfirm: (time) {
                        print('confirm $time');
                        _time = '${time.hour} : ${time.minute}';
                        setState(() {});
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 45.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 18.0,
                                  color: Colors.pink,
                                ),
                                Text(
                                  " $_time",
                                  style: TextStyle(
                                      color: Colors.pink,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Click to change",
                        style: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.only(top: 100),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shape: StadiumBorder(),
                  fixedSize: const Size(240, 80),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AllSet()),
                  );
                },
                child: const Text('or Currently Experiencing!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 100),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink,
                  shape: StadiumBorder(),
                  fixedSize: const Size(240, 80),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AllSet()),
                  );
                },
                child: const Text('Submit',
                    style: TextStyle(
                      fontSize: 20,
                    )),
              )

            ],
          ),
        ),
      ),
    );
  }
}

//@override List<int> layoutProportions() => [100, 100, 1];




