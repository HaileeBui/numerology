import 'dart:convert';

import 'package:numerology/model/theme_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Search {
  final String name, dob;

  Search({required this.name, required this.dob});

  factory Search.fromJson(Map<String, dynamic> jsonData) {
    return Search(
      name: jsonData['name'],
      dob: jsonData['dob'],
    );
  }

  static Map<String, dynamic> toMap(Search search) => {
        'name': search.name,
        'dob': search.dob,
      };

  static String encode(List<Search> searchs) => json.encode(
        searchs
            .map<Map<String, dynamic>>((search) => Search.toMap(search))
            .toList(),
      );

  static List<Search> decode(String searches) =>
      (json.decode(searches) as List<dynamic>)
          .map<Search>((item) => Search.fromJson(item))
          .toList();
}
