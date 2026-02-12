import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plant_disease_detector/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PlantDiseaseApp(initialRoute: '/login'));

    // Verify that we are on the login screen (not finding a zero counter because this is a different app)
    expect(find.text('Login'), findsWidgets);
  });
}
