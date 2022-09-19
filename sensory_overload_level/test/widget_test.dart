/* Citations: 
  Pub.Dev Github Repository (https://github.com/fluttercommunity/plus_plugins/blob/main/packages/sensors_plus/sensors_plus/test/sensors_test.dart)
  */

import 'package:checkmark/checkmark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sensory_overload_level/main.dart';

/* Check for navigation and buttons
*/

void main() {
  testWidgets('Horizontal Page has checkmark and X icon', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HorizontalPage()));

    expect(find.byType(CheckMark), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
  });

  testWidgets('Vertical Page has checkmark and X icon', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: VerticalPage()));

    expect(find.byType(CheckMark), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
  });

  testWidgets('Home Page has 2 buttons', (tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: MyHomePage(title: "Leveler")));

    expect(find.byType(ElevatedButton), findsNWidgets(2));
  });

  testWidgets('HButton Opens HorizontalPage', (tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: MyHomePage(title: "Leveler")));

    expect(find.byKey(const Key('HButton')), findsNWidgets(1));
    //Finder buttonFinder = find.byKey(const Key('HButton'));
    await tester.tap(find.byKey(Key('HButton')));
    await tester.pumpAndSettle();
    await tester.pump(); // Pump after every action to rebuild the widgets
    expect(find.byType(HorizontalPage), findsOneWidget);
  });

  testWidgets('VButton Opens VerticalPage', (tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: MyHomePage(title: "Leveler")));

    expect(find.byKey(const Key('VButton')), findsNWidgets(1));
    //Finder buttonFinder = find.byKey(const Key('HButton'));
    await tester.tap(find.byKey(Key('VButton')));
    await tester.pumpAndSettle();
    await tester.pump(); // Pump after every action to rebuild the widgets
    expect(find.byType(VerticalPage), findsOneWidget);
  });
}
