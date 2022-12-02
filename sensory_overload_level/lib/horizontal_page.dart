import 'package:flutter/material.dart';
import 'package:checkmark/checkmark.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'main.dart';

class HorizontalPage extends StatefulWidget {
  const HorizontalPage({super.key});

  @override
  _HorizontalPageState createState() => _HorizontalPageState();
}

class _HorizontalPageState extends State<HorizontalPage> {
  @override
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
  //Looking at z here
  Widget build(BuildContext context) {
    if (z != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Horizontal'),
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Text(
              //Able to find a method to truncate the double value into 3 decimal places
              //Value is now always going towards 0 so the user knows if they are getting closer
              "${(z!.abs() - 9.8).toStringAsPrecision(3)} units off",
              //z.toString(),
              style: const TextStyle(
                  color: Colors.orange,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),
            CheckMarkBox(),
            const SizedBox(height: 10),
            openX(checked),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Horizontal'),
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            const Text(
              //Able to find a method to truncate the double value into 3 decimal places
              //Value is now always going towards 0 so the user knows if they are getting closer
              "Value is null",
              //z.toString(),
              style: TextStyle(
                  color: Colors.orange,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),
            CheckMarkBox(),
            const SizedBox(height: 10),
            openX(checked),
          ],
        ),
      );
    }
  }
}