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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Numbers affect your life'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [Text('Name: ${widget.name}'), Text('DOB: ${widget.dob}')],
      ),
    );
  }
}
