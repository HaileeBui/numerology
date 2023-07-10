import 'package:flutter/material.dart';
import 'package:numerology_app/model/search.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:numerology_app/util/constants.dart';
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

  Future<void> saveSearches(List<Search> list) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SEARCH_KEY, Search.encode(list));
  }

  Future<void> deleteSearch(Search search) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final list = prefs.getString(SEARCH_KEY);

    List<Search> objectList = [];

    if (list != null) {
      objectList = Search.decode(list);
    }

    objectList.removeWhere(
        (item) => item.name == search.name && item.dob == search.dob);
    await prefs.setString(SEARCH_KEY, Search.encode(objectList));
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
              ? Theme(
                  data: ThemeData(
                    canvasColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: ReorderableListView.builder(
                      onReorder: (oldIndex, newIndex) => {
                            setState(
                              () {
                                if (newIndex > oldIndex) {
                                  newIndex -= 1;
                                }
                                final Search search =
                                    _searchList.removeAt(oldIndex);
                                _searchList.insert(newIndex, search);
                                saveSearches(_searchList);
                              },
                            ),
                          },
                      primary: false,
                      itemCount: _searchList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return item(index);
                      }),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(AppLocalizations.of(context)!.empty_return),
                )
        ]),
      ),
    );
  }

  Widget item(int index) {
    return Container(
      key: Key('$index'),
      margin: EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Dismissible(
          key: Key('$index'),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: AlignmentDirectional.centerEnd,
            color: Colors.black,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
          onDismissed: (direction) => {
            deleteSearch(_searchList[index]),
            setState(() {
              _searchList.removeAt(index);
            }),
          },
          child: AnimatedContainer(
            height: 55,
            width: screenWidth,
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 300 + (index * 100)),
            transform: Matrix4.translationValues(
                startAnimation ? 0 : screenWidth, 0, 0),
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.7),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth / 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
        ),
      ),
    );
  }
}
