//aeyrium sensor dart package
//https://pub.dev/documentation/aeyrium_sensor/latest/
//check mark sensor dart package
//https://pub.dev/packages/checkmark

//add x animation for not level

import 'package:flutter/material.dart';
import 'package:checkmark/checkmark.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:sensory_overload_level/horizontal_page.dart';
import 'package:sensory_overload_level/vertical_page.dart';
import 'package:sensory_overload_level/home_page.dart';

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

bool checked = false;
double? x, y, z;

//Method returns X if sensor not level
Icon openX(bool checked) {
  const Key("Icon");
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
