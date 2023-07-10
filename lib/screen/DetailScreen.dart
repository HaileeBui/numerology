import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DetailScreen extends StatefulWidget {
  String name, dob;

  DetailScreen({required this.name, required this.dob});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  Color purple = Colors.purple.withOpacity(0.8);
  Color blue = Color.fromARGB(255, 1, 90, 134).withOpacity(0.8);

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
                          width: screenWidth / 3,
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
                            CustomBar('Life path', '22/4', purple),
                            CustomBar('Attitude', '7', purple),
                            CustomBar('Generation', '6', purple),
                            CustomBar('Day of birth', '8', purple)
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
                          width: screenWidth / 3,
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
                            CustomBar('Expression', '22/4', blue),
                            CustomBar('Soul Urge', '7', blue),
                            CustomBar('Personality', '6', blue),
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
      width: screenHeight,
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
