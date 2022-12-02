import 'package:flutter/material.dart';
import 'package:checkmark/checkmark.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'main.dart';
import 'package:sensory_overload_level/horizontal_page.dart';
import 'package:sensory_overload_level/vertical_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application.

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Needed to initialize the accelerometer event in the home page due to the null check when displaying the accelerometer value

  void initState() {
    accelerometerEvents.listen(
      (AccelerometerEvent event) {
        if (mounted) {
          setState(
            () {
              x = event.x;
              y = event.y;
              z = event.z;
            },
          );
        }
        // check if level horizontally
        checked = (z!.abs() >= 9.8 && z!.abs() <= 9.82);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // onPressed move to these states/pages
    void _openHorizontal() {
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
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // create buttons that would navigate to the both levelers
            SizedBox(
              width: 300, // <-- Your width
              height: 100,
              child: ElevatedButton(
                key: const Key('HButton'),
                onPressed: _openHorizontal,
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 30)),
                child: const Text('Horizontal Level'),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 300, // <-- Your width
              height: 100,
              child: ElevatedButton(
                key: const Key('VButton'),
                onPressed: _openVertical,
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 30)),
                child: const Text('Vertical Level'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}