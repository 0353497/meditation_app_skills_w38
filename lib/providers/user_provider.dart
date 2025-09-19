import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String username;
  String email;
  List<String> selectedGoals;
  List<String> reminders;

  UserProvider({
    this.username = "Wouter",
    this.email = "wouter@canvasheroes.nl",
    this.selectedGoals = const [],
    this.reminders = const [],
  });

  void changeUserName(String newUserName) {
    username = newUserName;
    notifyListeners();
  }

  void changeEmail(String newEmail) {
    email = newEmail;
    notifyListeners();
  }

  void updateSelectedGoals(List<String> goals) {
    selectedGoals = goals;
    notifyListeners();
  }

  void addGoal(String goal) {
    selectedGoals = [...selectedGoals, goal];
    notifyListeners();
  }

  void removeGoal(String goal) {
    selectedGoals = selectedGoals.where((g) => g != goal).toList();
    notifyListeners();
  }

  void updateReminders(List<String> newReminders) {
    reminders = newReminders;
    notifyListeners();
  }

  void addReminder(String reminder) {
    reminders = [...reminders, reminder];
    notifyListeners();
  }

  void removeReminder(String reminder) {
    reminders = reminders.where((r) => r != reminder).toList();
    notifyListeners();
  }

  void clearAll() {
    username = "Wouter";
    email = "wouter@canvasheroes.nl";
    selectedGoals = const [];
    reminders = const [];
    notifyListeners();
  }
}