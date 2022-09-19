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
}
