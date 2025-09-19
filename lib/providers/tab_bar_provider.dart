import 'package:flutter/material.dart';

class TabBarProvider extends ChangeNotifier {
  bool showSnackbar;

  int currentSleepview;

  TabBarProvider({this.showSnackbar = true, this.currentSleepview = 0});
  void showTabBar(bool newValue) {
    showSnackbar = newValue;
    notifyListeners();
  }

  void changeCurrentSleepView(int newView) {
    currentSleepview = newView;
    notifyListeners();
  }
}