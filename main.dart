import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to GERD pH sensor app!',
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
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'GERD App Main Page'),
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
            const Text(
              'Your current pH measurement is:',
            ),
            SizedBox(   //Use of SizedBox
              height: 10,
            ),
            Text(
              '6.2',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(   //Use of SizedBox
              height: 40,
            ),
            const Text(
              'What do you want to record?',
            ),
            SizedBox(   //Use of SizedBox
              height: 20,
            ),
            Container(
              height: 50.0,
              child: RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)
                  ),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Physical Activity",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(   //Use of SizedBox
              height: 30,
            ),
            Container(
              height: 50.0,
              child: RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xff379147), Color(0xffa8e4a0)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)
                  ),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Meal intake",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),

                ),
              ),
            ),
            SizedBox(   //Use of SizedBox
              height: 30,
            ),
            Container(
              height: 50.0,
              child: RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xfff453a6), Color(0xffdca797)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)
                  ),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Unusual Symptoms",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),

                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
