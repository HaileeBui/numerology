import 'package:flutter/material.dart';
import 'package:numerology_app/screen/NumberDetailScreen.dart';

class DetailScreen extends StatefulWidget {
  String name, dob;

  DetailScreen({required this.name, required this.dob});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _totalMonth = 0;
  int _totalDay = 0;
  int _totalYear = 0;
  double screenHeight = 0;
  double screenWidth = 0;
  Color purple = Colors.purple.withOpacity(0.8);
  Color blue = Color.fromARGB(255, 1, 90, 134).withOpacity(0.8);

  List<String> _getDobArray() {
    return widget.dob.split('-');
  }

  List<int> _getSpecificNumbersArray(numbers) {
    final List<String> array = numbers.split('');
    return array.map(int.parse).toList();
  }

  List<int> _getIntArray(stringArr) =>
      stringArr.toString().split('').map(int.parse).toList();

  int _getSumFunction(array) => array.fold(0, (a, b) => a + b);

  int _getSum(array) {
    if (_getSumFunction(array) >= 10) {
      return _getSumFunction(
          _getSumFunction(array).toString().split('').map(int.parse).toList());
    } else {
      return _getSumFunction(array);
    }
  }

  String _getAttitudeNumber() {
    final total = _totalDay + _totalMonth;
    return _getSum(_getIntArray(total)).toString();
  }

  String _getLifePathNumber() {
    final total = _totalDay + _totalMonth + _totalYear;

    return _getSum(_getIntArray(total)).toString();
  }

  String _getSoulUrgeNumber() {
    final List<String> stringArr = widget.name.split(' ');
    int total = 0;
    for (var name in stringArr) {
      total = total + _getTotalVowel(name);
    }
    if (total.toString().split('').length == 1 || total == 11) {
      return total.toString();
    } else {
      return _getSum(_getIntArray(total)).toString();
    }
  }

  String _getPersonalityNumber() {
    final List<String> stringArr = widget.name.split(' ');
    int total = 0;
    for (var name in stringArr) {
      total = total + _getTotalCosonant(name);
    }
    if (total.toString().split('').length == 1) {
      return total.toString();
    } else {
      return _getSum(_getIntArray(total)).toString();
    }
  }

  String _getDestinyNumber() {
    final List<String> stringArr = widget.name.split(' ').join('').split('');
    int total = 0;
    for (var a in stringArr) {
      total = total + _getNumberFromAlphabelt(a);
    }
    if (total.toString().split('').length == 1 || total == 11) {
      return total.toString();
    } else {
      return _getSum(_getIntArray(total)).toString();
    }
  }

  bool _isVowel(a) => ['u', 'e', 'o', 'a', 'i', 'y'].contains(a);

  int _getNumberFromAlphabelt(a) {
    if (['a', 'j', 's'].contains(a)) {
      return 1;
    } else if (['b', 'k', 't'].contains(a)) {
      return 2;
    } else if (['c', 'l', 'u'].contains(a)) {
      return 3;
    } else if (['d', 'm', 'v'].contains(a)) {
      return 4;
    } else if (['e', 'n', 'w'].contains(a)) {
      return 5;
    } else if (['f', 'o', 'x'].contains(a)) {
      return 6;
    } else if (['g', 'p', 'y'].contains(a)) {
      return 7;
    } else if (['h', 'q', 'z'].contains(a)) {
      return 8;
    } else {
      return 9;
    }
  }

  int _getTotalVowel(name) {
    final array = name.split('');
    int total = 0;
    for (var a in array) {
      if (_isVowel(a)) {
        total = total + _getNumberFromAlphabelt(a);
      }
    }
    if (total.toString().split('').length == 1) {
      return total;
    } else {
      return _getSum(_getIntArray(total));
    }
  }

  int _getTotalCosonant(name) {
    final array = name.split('');
    int total = 0;
    for (var a in array) {
      if (!_isVowel(a)) {
        total = total + _getNumberFromAlphabelt(a);
      }
    }
    if (total.toString().split('').length == 1) {
      return total;
    } else {
      return _getSum(_getIntArray(total));
    }
  }

  @override
  void initState() {
    super.initState();
    final List<String> array = _getDobArray();
    _totalDay = _getSum(_getSpecificNumbersArray(array[2]));
    _totalMonth = _getSum(_getSpecificNumbersArray(array[1]));
    _totalYear = _getSum(_getSpecificNumbersArray(array[0]));
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Numbers affect your life'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBar('Date of birth numbers', '', purple),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: screenWidth / 2.5,
                          height: screenHeight / 5,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: purple,
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.settings_input_antenna,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => NumberDetail(
                                          number: _getLifePathNumber()))),
                              child: CustomBar(
                                  'Life path', _getLifePathNumber(), purple),
                            ),
                            CustomBar('Attitude', _getAttitudeNumber(), purple),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomBar('Name numbers', '', blue),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: screenWidth / 2.5,
                          height: screenHeight / 5,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: blue,
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.settings_accessibility,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomBar('Destiny', _getDestinyNumber(), blue),
                            CustomBar('Soul Urge', _getSoulUrgeNumber(), blue),
                            CustomBar(
                                'Personality', _getPersonalityNumber(), blue),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget CustomBar(String title, String number, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      width: screenWidth / 2,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              number,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
