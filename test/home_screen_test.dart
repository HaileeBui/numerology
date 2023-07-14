import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:numerology_app/model/search.dart';
import 'package:numerology_app/screen/HistoryScreen.dart';
import 'package:numerology_app/screen/HomeScreen.dart' show HomeScreen;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:numerology_app/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnRemoveMockFunction extends Mock implements Function {
  void call(String task);
}

class OnReorderMockFunction extends Mock implements Function {
  void call();
}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
  });

  getData() {
    List<Search> searchArray = [
      Search(name: 'name1', dob: 'dob1'),
      Search(name: 'name2', dob: 'dob2')
    ];
    SharedPreferences.setMockInitialValues(
        {SEARCH_KEY: Search.encode(searchArray)});
  }

  Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: child);
  }

  group('Home screen', () {
    testWidgets('title is display', (tester) async {
      await tester.pumpWidget(makeTestableWidget(child: HomeScreen()));
      await tester.pumpAndSettle();
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Date of birth'), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });
  });

  group('History screen', () {
    testWidgets('Show list', (WidgetTester tester) async {
      getData();
      await tester.pumpWidget(makeTestableWidget(
        child: HistoryScreen(),
      ));
      await tester.pumpAndSettle();

      expect(find.text('name1'), findsOneWidget);
      expect(find.text('dob1'), findsOneWidget);
      expect(find.text('name2'), findsOneWidget);
      expect(find.text('dob2'), findsOneWidget);
    });
  });
}
