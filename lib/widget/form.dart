import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:numerology/model/search.dart';
import 'package:numerology/screen/DetailScreen.dart';
import 'package:numerology/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({super.key});

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  List<Search> _searchList = [];
  TextEditingController _dateInput = TextEditingController();
  TextEditingController _nameInput = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _validate = false;

  @override
  void initState() {
    _dateInput.text = "";
    super.initState();
  }

  Future<void> saveSearch(Search newSearch) async {
    final prefs = await SharedPreferences.getInstance();
    final currentString = prefs.getString(SEARCH_KEY);

    List<Search> objectList = [];

    if (currentString != null) {
      objectList = Search.decode(currentString);
    }

    Search existingObject;
    try {
      existingObject = objectList.firstWhere(
          (obj) => obj.name == newSearch.name && obj.dob == newSearch.dob);
      print('existing obj: $existingObject');
    } catch (e) {
      objectList.add(newSearch);
    }

    await prefs.setString(SEARCH_KEY, Search.encode(objectList));
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
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Enter your name',
                labelText: AppLocalizations.of(context)!.name,
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
                  labelText: AppLocalizations.of(context)!.dob,
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
                      saveSearch(
                          Search(name: _nameInput.text, dob: _dateInput.text));
                      // If the form is valid, display a Snackbar.
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailScreen(
                              name: _nameInput.text, dob: _dateInput.text)));
                    }
                  },
                  child: Text(AppLocalizations.of(context)!.see_results),
                )),
          ],
        ));
  }
}
