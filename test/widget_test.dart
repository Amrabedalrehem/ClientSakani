import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('SakaniApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SakaniApp());

    // Basic smoke test - app should start
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
