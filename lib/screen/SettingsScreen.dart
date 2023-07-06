import 'package:flutter/material.dart';
import 'package:numerology/providers/theme_model.dart';
import 'package:numerology/widget/switch.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void changeBackground(ThemeModal notifier) {
    notifier.isDark ? notifier.isDark = false : notifier.isDark = true;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModal themeNotifier, child) {
      return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Change background'),
                    SizedBox(
                      width: 50,
                    ),
                    CustomSwitch(
                        dark: themeNotifier.isDark,
                        func: () {
                          changeBackground(themeNotifier);
                        })
                  ],
                )
              ],
            )),
      );
    });
  }
}
