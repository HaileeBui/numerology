import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:numerology_app/model/search.dart';
import 'package:numerology_app/providers/theme_model.dart';
import 'package:numerology_app/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

// a generic Listener class, used to keep track of when a provider notifies its listeners
class Listener<T> extends Mock {
  void call(T? previous, T next);
}

void main() {
  group(Search, () {
    group('get Search', () {
      test('return empty array if there is no searches saved', () async {
        SharedPreferences.setMockInitialValues({});

        final SharedPreferences prefs = await SharedPreferences.getInstance();

        final list = prefs.getString(SEARCH_KEY);
        const expectedValue = 0;
        final actualValue = list != null ? Search.decode(list).length : 0;

        expect(expectedValue, actualValue);
      });

      test('return correct value if there are searches', () async {
        List<Search> searchArray = [
          Search(name: 'name1', dob: 'dob1'),
          Search(name: 'name2', dob: 'dob3')
        ];
        SharedPreferences.setMockInitialValues(
            {SEARCH_KEY: Search.encode(searchArray)});

        final SharedPreferences prefs = await SharedPreferences.getInstance();

        final list = prefs.getString(SEARCH_KEY);
        const expectedValue = 2;
        final actualValue = list != null ? Search.decode(list).length : 0;

        expect(expectedValue, actualValue);
      });
    });
    group('save Search', () {
      test('stores correct value of search on save', () async {
        List<Search> searchArray = [
          Search(name: 'name1', dob: 'dob1'),
          Search(name: 'name2', dob: 'dob3')
        ];
        SharedPreferences.setMockInitialValues(
            {SEARCH_KEY: Search.encode(searchArray)});

        final SharedPreferences prefs = await SharedPreferences.getInstance();

        searchArray.add(Search(name: 'name3', dob: 'dob3'));
        await prefs.setString(SEARCH_KEY, Search.encode(searchArray));

        const countValue = 3;
        final list = prefs.getString(SEARCH_KEY);
        const expectedValue = countValue;
        final actualValue = list != null ? Search.decode(list).length : 0;

        expect(expectedValue, actualValue);
      });

      test('stores correct value of search on delte', () async {
        List<Search> searchArray = [
          Search(name: 'name1', dob: 'dob1'),
          Search(name: 'name2', dob: 'dob3')
        ];
        SharedPreferences.setMockInitialValues(
            {SEARCH_KEY: Search.encode(searchArray)});

        final SharedPreferences prefs = await SharedPreferences.getInstance();

        searchArray.removeAt(searchArray.length - 1);
        await prefs.setString(SEARCH_KEY, Search.encode(searchArray));

        const countValue = 1;
        final list = prefs.getString(SEARCH_KEY);
        const expectedValue = countValue;
        final actualValue = list != null ? Search.decode(list).length : 0;

        expect(expectedValue, actualValue);
      });
    });
  });
}
