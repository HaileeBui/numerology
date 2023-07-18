import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:numerology_app/model/life_path.dart';

class NumberDetail extends StatefulWidget {
  String number;

  NumberDetail({required this.number});

  @override
  State<NumberDetail> createState() => _NumberDetailState();
}

class _NumberDetailState extends State<NumberDetail> {
  String text = '';
  LifePath obj = LifePath('', '');

  void getData() async {
    print('called');
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('numbers/${widget.number}').get();
    if (snapshot.exists) {
      Map<String, dynamic> json = jsonDecode(jsonEncode(snapshot.value));
      setState(() {
        obj = LifePath.fromJson(json);
      });
    } else {
      print('No data available.');
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(60))),
              padding: EdgeInsets.symmetric(horizontal: 30),
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                widget.number,
                style: TextStyle(fontSize: 100, color: Colors.purple),
              ),
            ),
            Text(
              obj.meaning,
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
