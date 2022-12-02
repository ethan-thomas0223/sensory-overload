import 'package:flutter/material.dart';
import 'package:checkmark/checkmark.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'main.dart';

class VerticalPage extends StatefulWidget {
  const VerticalPage({super.key});

  @override
  _VerticalPageState createState() => _VerticalPageState();
}

class _VerticalPageState extends State<VerticalPage> {
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
        // check if level vertically
        checked = (y!.abs() >= 9.8 && y!.abs() <= 9.82) ||
            (x!.abs() >= 9.8 && x!.abs() <= 9.82);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (y != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Vertical'),
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            //Same method as up above in the horizontal page state
            Text((y!.abs() - 9.8).toStringAsPrecision(3) + " units off",
                //Text(y.toString(),
                style: const TextStyle(
                    color: Colors.orange,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w900)),
            const SizedBox(height: 10),
            CheckMarkBox(),
            const SizedBox(height: 10),
            openX(checked),
          ],
        ),
      );
    } else {
      //Need this else statement here to pass the unit tests
      return Scaffold(
        appBar: AppBar(
          title: const Text('Vertical'),
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            //Same method as up above in the horizontal page state
            const Text("Y is null",
                //Text(y.toString(),
                style: const TextStyle(
                    color: Colors.orange,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w900)),
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