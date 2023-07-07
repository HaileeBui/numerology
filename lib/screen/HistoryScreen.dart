import 'package:flutter/material.dart';
import 'package:numerology/model/search.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:numerology/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Search> _searchList = [];
  double screenHeight = 0;
  double screenWidth = 0;
  bool startAnimation = false;

  @override
  void initState() {
    getSearches();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  Future<void> deleteSearch() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final list = prefs.getString(SEARCH_KEY);

  }

  Future<void> deleteAllSearches() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(SEARCH_KEY);
    setState(() {
      _searchList = [];
    });
  }

  Future<List<Search>> getSearches() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final list = prefs.getString(SEARCH_KEY);
    if (list != null) {
      setState(() {
        _searchList = Search.decode(list);
      });
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.previous_searches,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.purple),
              ),
              _searchList.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.delete_outline),
                      color: Colors.purple,
                      tooltip: 'Delete all',
                      onPressed: () {
                        deleteAllSearches();
                      },
                    )
                  : SizedBox.shrink(),
            ],
          ),
          const SizedBox(height: 20),
          _searchList.isNotEmpty
              ? ListView.builder(
                  primary: false,
                  itemCount: _searchList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return item(index);
                  })
              : Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(AppLocalizations.of(context)!.empty_return),
                )
        ]),
      ),
    );
  }

  Widget item(int index) {
    return Dismissible(
      key: Key('$index'),
      onDismissed: (direction) => {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                '${_searchList[index].name} - ${_searchList[index].dob} deleted')))
      },
      child: AnimatedContainer(
        height: 55,
        width: screenWidth,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 300 + (index * 100)),
        transform:
            Matrix4.translationValues(startAnimation ? 0 : screenWidth, 0, 0),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.purple.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              _searchList[index].name,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              _searchList[index].dob,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            )
          ]),
        ),
      ),
    );
  }
}
