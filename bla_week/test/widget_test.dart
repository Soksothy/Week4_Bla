// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bla_week/main.dart';
import 'package:bla_week/repository/mock/mock_rides_repository.dart';
import 'package:bla_week/repository/mock/mock_ride_preferences_repository.dart';
import 'package:bla_week/repository/mock/mock_locations_repository.dart';
import 'package:bla_week/service/rides_service.dart';
import 'package:bla_week/service/ride_prefs_service.dart';
import 'package:bla_week/service/locations_service.dart';

void main() {
  setUp(() {
    // Initialize all required services before each test
    RidePrefService.initialize(MockRidePreferencesRepository());
    LocationsService.initialize(MockLocationsRepository());
    RidesService.initialize(MockRidesRepository());
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
