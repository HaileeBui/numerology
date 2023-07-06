import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:numerology/screen/DetailScreen.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({super.key});

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  TextEditingController _dateInput = TextEditingController();
  TextEditingController _nameInput = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _validate = false;

  @override
  void initState() {
    _dateInput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _nameInput,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Enter your name',
                labelText: 'Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            TextField(
              controller: _dateInput,
              decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  labelText: "Date of birth",
                  errorText: _validate ? 'Please enter DOB' : null),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100));

                if (pickedDate != null) {
                  setState(() {
                    _validate = false;
                  });
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  setState(() {
                    _dateInput.text = formattedDate;
                  });
                } else {}
              },
            ),
            Container(
                padding: const EdgeInsets.only(top: 40.0),
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _dateInput.text.isEmpty
                          ? _validate = true
                          : _validate = false;
                    });
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a Snackbar.
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailScreen(
                              name: _nameInput.text, dob: _dateInput.text)));
                    }
                  },
                  child: Text('See results'),
                )),
          ],
        ));
  }
}
