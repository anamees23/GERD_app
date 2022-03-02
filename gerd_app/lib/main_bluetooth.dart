import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';
import 'db/databases.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Bluetooth Test'),
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

class _MyHomePageState extends State<MyHomePage> {
  var _pH1 = 0.0;
  var _pH2 = 0.0;
  bool _isButtonDisabled = false;
  DateTime currentDate1 = DateTime.now();
  DateTime currentDate2 = DateTime.now();

  @override
  void initState() {
    _isButtonDisabled = false;
    super.initState();
    const oneSec = const Duration(seconds: 2);
    Timer _timer = new Timer.periodic(oneSec, (timer) {
      if (_isButtonDisabled == true) {
        timer.cancel();
      }
      var rng = Random();
      setState(() {
        _pH1 = rng.nextInt(140) / 10.0;
        _pH2 = rng.nextInt(140) / 10.0;
        _timeSync();
      });
    });
  }

  void _timeSync() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen
      currentDate2 = DateTime.now();
      currentDate1 = currentDate2.add(const Duration(seconds: -1)); //DateTime
    });

    ph_data new_pH1 = new ph_data(_pH1, currentDate1);
    ph_data new_pH2 = new ph_data(_pH2, currentDate2);
    new_pH1.insert_ph_data(new_pH1);
    new_pH2.insert_ph_data(new_pH2);
  }

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
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 1),
            const Text(
              'first pH value:',
            ),
            Text(
              '$_pH1',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              ('first time: ' + '$currentDate1'),
            ),
            Spacer(flex: 1),
            const Text(
              'second pH value:',
            ),
            Text(
              '$_pH2',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              ('second time: ' + '$currentDate2'),
            ),
            Spacer(flex: 1),
            _buildCounterButton(),
            Spacer(flex: 1)
          ],
        ),
      ),
      //floatingActionButton: FloatingActionButton(
      //  onPressed: _incrementCounter,
      //  tooltip: 'Increment',
      //  child: const Icon(Icons.add),
      //), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildCounterButton() {
    return new RaisedButton(
        child: new Text(
            _isButtonDisabled ? "DATA GENERATION OFF" : "DATA GENERATION ON"),
        onPressed: () {
          setState(() {
            _isButtonDisabled = true;
          });
        }
        //_isButtonDisabled ? null : _incrementCounter,
        );
  }
}
