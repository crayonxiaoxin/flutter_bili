import 'package:flutter/material.dart';
import 'package:flutter_bili/page/unknown_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// widget 测试
  testWidgets("测试 UnknownPage", (WidgetTester widgetTester) async {
    var app = MaterialApp(
      home: UnknownPage(),
    );
    await widgetTester.pumpWidget(app);
    expect(find.text("12345"), findsOneWidget);
    expect(find.text("404"), findsNothing);
  });
}
