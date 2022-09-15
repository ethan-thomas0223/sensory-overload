//mobile sensory dart package package below:
//https://pub.dev/packages/sensors_plus/install

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:checkmark/checkmark.dart';
import 'package:aeyrium_sensor/aeyrium_sensor.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(), // becomes the route named '/'
      routes: <String, WidgetBuilder>{
        '/a': (BuildContext context) => HorizontalPage(),
        '/b': (BuildContext context) => VerticalPage(),
        '/c': (BuildContext context) => MyHomePage(title: 'Leveler'),
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leveler',
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
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'Leveler'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // Test Commit
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
    // onPressed move to these states
    void _openHoizontal() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HorizontalPage(),
        ),
      );
    }

    void _openVertical() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const VerticalPage(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // create buttons that would navigate to the both levelers
            TextButton(
              onPressed: _openHoizontal,
              child: const Text('Horizontal Level'),
            ),
            TextButton(
              onPressed: _openVertical,
              child: const Text('Vertical Level'),
            ),
          ],
        ),
      ),
    );
  }
}

class HorizontalPage extends StatefulWidget {
  const HorizontalPage({super.key});

  @override
  _HorizontalPageState createState() => _HorizontalPageState();
}

class _HorizontalPageState extends State<HorizontalPage> {
  bool checkedH = false;
  late double pitchH;
  late double rollH;

  @override
  void initState() {
    super.initState();
    AeyriumSensor.sensorEvents.listen(
      (SensorEvent event) {
        setState(
          () {
            pitchH = event.pitch;
            rollH = event.roll;
          },
        );
        // check if level horizontally
        if (pitchH < -1.47 && pitchH > -1.53) {
          checkedH = true;
        } else {
          checkedH = false;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horizontal'),
      ),
      body: Column(
        children: [
          Text(pitchH.toString()),
          Text(rollH.toString()),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 200,
              width: 200,
              child: CheckMark(
                active: checkedH,
                curve: Curves.decelerate,
                duration: const Duration(milliseconds: 500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VerticalPage extends StatefulWidget {
  const VerticalPage({super.key});

  @override
  _VerticalPageState createState() => _VerticalPageState();
}

class _VerticalPageState extends State<VerticalPage> {
  late double pitchV;
  late double rollV;
  bool checkedV = false;

  @override
  void initState() {
    super.initState();
    AeyriumSensor.sensorEvents.listen(
      (SensorEvent event) {
        setState(
          () {
            pitchV = event.pitch;
            rollV = event.roll;
          },
        );
        // check if level vertically
        if (pitchV <= 0.005 && pitchV >= -0.005) {
          checkedV = true;
        } else {
          checkedV = false;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vertical'),
      ),
      body: Column(
        children: [
          Text(pitchV.toString()),
          Text(rollV.toString()),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 200,
              width: 200,
              child: CheckMark(
                active: checkedV,
                curve: Curves.decelerate,
                duration: const Duration(milliseconds: 500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
