import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_tts/flutter_tts.dart';

//import 'LocalNotificationsScreen.dart'
//import 'package:intl/intl.dart';

// Choice #1 for notifications
//import 'package:awesome_notifications/awesome_notifications.dart';
// to store data locally, such as login credentials
// SharedPreferences can be used to store critical data such as passwords,
// tokens, and complex relational data.

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  // subscribe to topic on each app start-up
  await messaging.subscribeToTopic('test');
  print('User granted permission: ${settings.authorizationStatus}');
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
  //First and last
  String firstname = "No Value";
  String lastname = "No Value";
  String mhr = "No Value";
  String email = "No Value";
  String pin = "No Value";

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
                'First Name',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                //Use of SizedBox
                height: 10,
              ),
        Container(
            width: 350.0,
            child:TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your first name',
                ),
              onChanged: (value) => firstname = value,
              ),
        ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
              //Text(text),
              const Text(
                'Last Name',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                //Use of SizedBox
                height: 10,
              ),
              Container(
                width: 350.0,
                child:TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your last name',
                  ),
                  onChanged: (value) => lastname = value,
                ),
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
              const Text(
                'Medical Health Record Number',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                //Use of SizedBox
                height: 10,
              ),
        Container(
            width: 350.0,
            child:TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your MHR number',
                ),
              onChanged: (value) => mhr = value,
              ),
        ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
              const Text(
                'Doctor email',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                //Use of SizedBox
                height: 10,
              ),
        Container(
            width: 350.0,
            child:TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your doctor's email",
                ),
              onChanged: (value) => email = value,
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
                height: 10,
              ),
        Container(
            width: 350.0,
            child:TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your PIN number',
                ),
              onChanged: (value) => pin = value,
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

                  //timestamp here
                  //print(name);
                  //print(mhr);
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
  String messageTitle = "Empty";
  String notificationAlert = "alert";
  final FlutterTts flutterTts = FlutterTts();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    speak () async {
      print(await flutterTts.getLanguages);
      await flutterTts.setLanguage("en-Us");
      await flutterTts.speak("Your current pH measurement is displayed below. What do you want to record? Physical Activity. Meal Intake. Unusual Symptoms.");
    }
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FloatingActionButton(
            onPressed: () => speak(),
            heroTag: null,
            backgroundColor: Colors.redAccent,
            child: const Icon(Icons.record_voice_over),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondScreen()),
              );
            },
            heroTag: null,
            child: const Icon(Icons.other_houses_rounded),
          ),
        ],
      ),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Text(
            //  notificationAlert,
            //),
            //Text(
            //  messageTitle,
            //  style: Theme.of(context).textTheme.headline4,
            //),
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PhyAct()));
                  //Navigator.push(
                    //context,
                    //MaterialPageRoute(builder: (context) => const PhyAct()),
                  //);
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const SecondScreen()),
      //     );
      //   },
      //   child: const Icon(Icons.other_houses_rounded),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

  final FlutterTts flutterTts = FlutterTts();
  //const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    speak () async {
      print(await flutterTts.getLanguages);
      await flutterTts.setLanguage("en-Us");
      await flutterTts.speak("Welcome to My GERD Tracker! Submit Current Status. View My Data. Ask for Help.");
    }
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
                  MaterialPageRoute(builder: (context) => DataView()),
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


class getHelp extends StatefulWidget {
  const getHelp({Key? key}) : super(key: key);

  @override
  _getHelpState createState() => _getHelpState();
}

class _getHelpState extends State<getHelp> {
//class getHelp extends StatelessWidget {
 // const getHelp({Key? key}) : super(key: key);

  String messagetodoctor = "No Value";

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
        Container(
            width: 500.0,
            child:TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter the message',
                ),
              onChanged: (value) => messagetodoctor = value,
              ),
        ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
              // const Text(
              //   'Click to add a photo',
              //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              //   textAlign: TextAlign.center,
              // ),
              // SizedBox(
              //   //Use of SizedBox
              //   height: 30,
              // ),
              //

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

class DataView extends StatefulWidget {
  _DataView createState() => _DataView();
//const DataView ({Key? key}) : super(key: key);
}

class _DataView extends State<DataView> {


  late List<BravoData> _chartData;

  @override
  void initState() {
    _chartData = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          body: SfCartesianChart(series: <ChartSeries>[
            LineSeries<BravoData, double>(dataSource: _chartData,
                xValueMapper: (BravoData bravo, _) => bravo.BravoTime,
                yValueMapper: (BravoData bravo, _) => bravo.BravopH)
          ]),));

  }

  List<BravoData> getChartData(){
    final List<BravoData> chartData = [
      BravoData(2, 5.1),
      BravoData(3, 4.2),
      BravoData(4, 5.6),
      BravoData(5, 5.3),
      BravoData(6, 4.5),
      BravoData(7, 4.0),
      BravoData(8, 4.7),
      BravoData(9, 4.4),
      BravoData(10, 5.4)
    ];
    return chartData;
  }

}

class BravoData {
  BravoData(this.BravoTime, this.BravopH);
  late final double BravoTime;
  late final double BravopH;
}
class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {

  final FlutterTts flutterTts = FlutterTts();
  //const ThirdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    speak () async {
      print(await flutterTts.getLanguages);
      await flutterTts.setLanguage("en-Us");
      await flutterTts.speak("To submit your activity status, meal status, or to record any unusual symptoms, click on the Submit Current Status icon on the home page. To read aloud the text on any page, click the red icon that depicts a person speaking.");
    }
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
class PhyAct extends StatefulWidget {


  @override
  State<PhyAct> createState() => _PhyAct();
}

class _PhyAct extends State<PhyAct> {
  String? _value;
  String activitydescribed = "No Value";

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
              //Dropdown
              DropdownButton<String>(
                value: _value,
                hint: Text('Please select'),
                onChanged: (value) {
                  print(value);
                  setState(() {
                    _value = value;
                  });
                },
                items: ['Walking', 'Standing', 'Sleeping', 'Laying Down', 'Exercising', 'Other (please specify)'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
              const Text(
                'If other:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                textAlign: TextAlign.left,
              ),
        Container(
            width: 500.0,
            child:TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter the activity',
                ),
              onChanged: (value) => activitydescribed = value,
              ),
        ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
              const Text(
                'Time of Activity',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),

              // Input date and time here
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
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),

              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
              //ElevatedButton(
               // style: ElevatedButton.styleFrom(
                //  primary: Colors.blue,
                  //shape: StadiumBorder(),
                  //fixedSize: const Size(240, 80),
                //),
                //onPressed: () {
                  //Navigator.push(
                    //context,
                    //MaterialPageRoute(builder: (context) => const AllSet()),
                  //);
                //},
                //child: const Text('Submit',
                  //  style: TextStyle(
                    //  fontSize: 20,
                    //)),
              //),
              //SizedBox(
                //Use of SizedBox
                //height: 30,
              //),
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

class MealInt extends StatefulWidget {
  const MealInt({Key? key}) : super(key: key);

  @override
  _MealIntState createState() => _MealIntState();
}

class _MealIntState extends State<MealInt> {
//class getHelp extends StatelessWidget {
  // const getHelp({Key? key}) : super(key: key);

  String mealdescribed = "No Value";

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
                'Meal (Food or Drink)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
        Container(
            width: 500.0,
            child:TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter the meal',
                ),
              onChanged: (value) => mealdescribed = value,
              ),
        ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
              const Text(
                'Time of Meal',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),

              // Input date and time here
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
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),

              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     primary: Colors.green,
              //     shape: StadiumBorder(),
              //     fixedSize: const Size(240, 80),
              //   ),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => const AllSet()),
              //     );
              //   },
              //   child: const Text('Submit',
              //       style: TextStyle(
              //         fontSize: 20,
              //       )),
              // ),
              // SizedBox(
              //   //Use of SizedBox
              //   height: 30,
              // ),
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

class Sympt extends StatefulWidget {
  const Sympt({Key? key}) : super(key: key);

  @override
  _SymptState createState() => _SymptState();
}

class _SymptState extends State<Sympt> {
//class getHelp extends StatelessWidget {
  // const getHelp({Key? key}) : super(key: key);

  String symptomdescribed = "No Value";

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
                'What are you feeling?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
        Container(
            width: 500.0,
            child:TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter the symptom',
                ),
              onChanged: (value) => symptomdescribed = value,
              ),
        ),
              SizedBox(
                //Use of SizedBox
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shape: StadiumBorder(),
                  fixedSize: const Size(320, 50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ExplainSympts()),
                  );
                },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                children: [
                  Text('What are unusual symptoms?   ',
                    style: TextStyle(
                      fontSize: 13,
                    )),
        Icon( // <-- Icon
          Icons.help,
          size: 24.0,
        ),
        ],
              ),
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),
              const Text(
                'Time of start',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                //Use of SizedBox
                height: 30,
              ),

              // Input date and time here
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
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ),

              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     primary: Colors.pink,
              //     shape: StadiumBorder(),
              //     fixedSize: const Size(240, 80),
              //   ),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => const AllSet()),
              //     );
              //   },
              //   child: const Text('Submit',
              //       style: TextStyle(
              //         fontSize: 20,
              //       )),
              // ),
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

class ExplainSympts extends StatelessWidget {
  const ExplainSympts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('What are unusual symptoms?'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                '- Heartburn (burning sensation in your chest)',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                //Use of SizedBox
                height: 8,
              ),
              const Text(
                '- Chest pain',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                //Use of SizedBox
                height: 8,
              ),
              const Text(
                '- Difficulty swallowing',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                //Use of SizedBox
                height: 8,
              ),
              const Text(
                '- Feeling of lump in throat',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                //Use of SizedBox
                height: 8,
              ),
              const Text(
                '- Regurgitation (food or sour liquid)',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                //Use of SizedBox
                height: 8,
              ),
              const Text(
                '- Vomiting',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                //Use of SizedBox
                height: 8,
              ),
              const Text(
                '- Sore throat and hoarseness',
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
                child: const Text('Go back and record your symptoms',
                    style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
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

class HomeScreenBlue extends StatefulWidget {
  @override
  _HomeScreenBlueState createState() => _HomeScreenBlueState();
}

class _HomeScreenBlueState extends State<HomeScreenBlue> {
  String _date = "Not set";
  String _time = "Not set";
  late DateTime DoingNow;


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
                    MaterialPageRoute(builder: (context) => CurrentlyDoingTimeActivity()),
                  );
                  DoingNow = DateTime.now();
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
class CurrentlyDoingTimeActivity extends StatefulWidget {
  @override
  _CurrentlyDoingTimeActivity createState() => _CurrentlyDoingTimeActivity();
}

class _CurrentlyDoingTimeActivity extends State<CurrentlyDoingTimeActivity> {
  String _time = "Not set";
  late DateTime DoingNow;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Input Estimated Time'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Please input the estimated time that you think you will take to complete this activity',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 100),
                    ),
                    Container(
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
                                  MaterialPageRoute(builder: (context) => HomeScreenBlue()),
                                );
                              },
                              child: const Text('Back',
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
                          ]
                      ),
                    ),
                  ],
                ),
              ],
            )
        )
    );
  }
}



class HomeScreenGreen extends StatefulWidget {
  @override
  _HomeScreenGreenState createState() => _HomeScreenGreenState();
}

class _HomeScreenGreenState extends State<HomeScreenGreen> {
  String _date = "Not set";
  String _time = "Not set";
  late DateTime DoingNow;

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
                    MaterialPageRoute(builder: (context) => CurrentlyDoingTimeMeal()),
                  );
                  DoingNow = DateTime.now();
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

class CurrentlyDoingTimeMeal extends StatefulWidget {
  @override
  _CurrentlyDoingTimeMeal createState() => _CurrentlyDoingTimeMeal();
}

class _CurrentlyDoingTimeMeal extends State<CurrentlyDoingTimeMeal> {
  String _time = "Not set";
  late DateTime DoingNow;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Input Estimated Time'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Please input the estimated time that you think you will take to complete your meal',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 100),
                    ),
                    Container(
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomeScreenBlue()),
                                );
                              },
                              child: const Text('Back',
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
                          ]
                      ),
                    ),
                  ],
                ),
              ],
            )
        )
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
  late DateTime DoingNow;

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
                  DoingNow = DateTime.now();
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