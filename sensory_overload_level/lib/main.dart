//aeyrium sensor dart package
//https://pub.dev/documentation/aeyrium_sensor/latest/
//check mark sensor dart package
//https://pub.dev/packages/checkmark

//add x animation for not level

import 'package:flutter/material.dart';
import 'package:checkmark/checkmark.dart';
import 'package:sensors_plus/sensors_plus.dart';

// build icon data
const IconData cancel_outlined = IconData(0xef28, fontFamily: 'MaterialIcons');

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
        primarySwatch: Colors.orange,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.orange,
            ), //button color
            foregroundColor: MaterialStateProperty.all<Color>(
              Colors.white,
            ),
          ),
        ),
      ),
      home: const MyHomePage(title: 'The Leveler'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application.

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

bool checked = false;
double? x, y, z;

//Method returns X if sensor not level
Icon openX(bool checked) {
  if (!checked) {
    return const Icon(
      cancel_outlined,
      color: Colors.red,
      size: 300,
    );
  } else {
    return const Icon(cancel_outlined, color: Colors.white);
  }
}

Color getGradient(double z, bool horizontal) {
  z = z.abs();
  // shifts through red to yellow from 0 - 9.0 (yellowCutoff) out of the 0 - 9.8 range of the sensor values.
  // shifts through yellow to green for the remaining 0.8.
  double yellowCutoff = 9.0;
  double h;
  if (horizontal) {
    if (z < yellowCutoff) {
      h = 60 * (z/yellowCutoff);
    } else {
      h = 60 + 60 * ((z-yellowCutoff)/(9.8-yellowCutoff));
    }
  } else {
    
    if (z > 9.8 - yellowCutoff) {
      h = 60 * ((z-9.8).abs()/yellowCutoff);
    } else {
      h = 60 + 60 * (((z-9.8).abs()-yellowCutoff)/(9.8-yellowCutoff));
    }
  }
  // hsl color as per https://codewithandrea.com/articles/hsl-colors-explained-flutter/
  return HSLColor.fromAHSL(1.0, h, 1.0, .5).toColor();
}

// Awesome code here!
class CheckMarkBox extends StatelessWidget {
  const CheckMarkBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 200,
        width: 200,
        child: CheckMark(
          active: checked,
          curve: Curves.decelerate,
          duration: const Duration(milliseconds: 500),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horizontal'),
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: 
          (x != null && y != null && z != null)
          ?
          getGradient(z!, true)
          :
          Colors.red,
        child: Column(
          children: [
            Text(
              z.toString(),
              style: const TextStyle(
                  color: Colors.orange,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w900),
            ),
            // const SizedBox(height: 10),
            const Spacer(),
            CheckMarkBox(),
            // const SizedBox(height: 10),
            openX(checked),
          ],
        ),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vertical'),
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: 
          (x != null && y != null && z != null)
          ?
          getGradient(z!, false)
          :
          Colors.red,
        child: Column(
          children: [
            Text(y.toString(),
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
      ),
    );
  }
}
