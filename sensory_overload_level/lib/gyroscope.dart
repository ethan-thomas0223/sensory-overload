import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/material.dart';

class Gyroscope extends StatefulWidget {
  const Gyroscope({Key? key}) : super(key: key);

  @override
  _GyroscopeState createState() => _GyroscopeState();
}

class _GyroscopeState extends State<Gyroscope> {
  double x = 0, y = 0, z = 0;
  String direction = "none";

  @override
  void initState() {
    gyroscopeEvents.listen((GyroscopeEvent event) {
      print(event);

      x = event.x;
      y = event.y;
      z = event.z;

      //rough calculation, you can use
      //advance formula to calculate the orentation
      if (x > 0) {
        direction = "back";
      } else if (x < 0) {
        direction = "forward";
      } else if (y > 0) {
        direction = "left";
      } else if (y < 0) {
        direction = "right";
      }

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gyroscope Sensor"),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(30),
          child: Column(children: [
            Text(
              direction,
              style: const TextStyle(fontSize: 30),
            )
          ])),
    );
  }
}
