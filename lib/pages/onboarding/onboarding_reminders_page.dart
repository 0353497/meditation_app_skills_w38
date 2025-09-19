import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meditation_app/pages/home_page.dart';
import 'package:meditation_app/pages/sign_in_page.dart';
import 'package:meditation_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class OnboardingRemindersPage extends StatefulWidget {
  const OnboardingRemindersPage({super.key});

  @override
  State<OnboardingRemindersPage> createState() => _OnboardingRemindersPageState();
}

class _OnboardingRemindersPageState extends State<OnboardingRemindersPage> {
  DateTime selectedTime = DateTime(2025, 1, 1, 10);
  List<String> selectedDays = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Saturday"
  ];

  void _saveReminders() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    
    String timeString = "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}";
    
    List<String> reminders = selectedDays.map((day) => "$day at $timeString").toList();
    
    userProvider.updateReminders(reminders);
    
    Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("What time would you \n like to meditate?",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
                ),
                Text("Any time you can choose but we recommend \n first thing in the morning.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Color(0xffF5F5F9)
                  ),
                  height: 200,
                  width: MediaQuery.of(context).size.width -30,
                  child: CupertinoDatePicker(
                    initialDateTime: selectedTime,
                    backgroundColor: Color(0xffF5F5F9),
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (time) {
                      setState(() {
                        selectedTime = time;
                      });
                    }
                  ),
                ),
              Text("Which day would you \nlike to meditate?",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
                ),
                  Text("Everyday is the best, but we recommend picking at least five.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DayButton(text: "S", day: "Sunday", selectedDays: selectedDays, onToggle: (day, isSelected) {
                      setState(() {
                        if (isSelected) {
                          selectedDays.add(day);
                        } else {
                          selectedDays.remove(day);
                        }
                      });
                    }),
                    DayButton(text: "M", day: "Monday", selectedDays: selectedDays, onToggle: (day, isSelected) {
                      setState(() {
                        if (isSelected) {
                          selectedDays.add(day);
                        } else {
                          selectedDays.remove(day);
                        }
                      });
                    }),
                    DayButton(text: "T", day: "Tuesday", selectedDays: selectedDays, onToggle: (day, isSelected) {
                      setState(() {
                        if (isSelected) {
                          selectedDays.add(day);
                        } else {
                          selectedDays.remove(day);
                        }
                      });
                    }),
                    DayButton(text: "W", day: "Wednesday", selectedDays: selectedDays, onToggle: (day, isSelected) {
                      setState(() {
                        if (isSelected) {
                          selectedDays.add(day);
                        } else {
                          selectedDays.remove(day);
                        }
                      });
                    }),
                    DayButton(text: "T", day: "Thursday", selectedDays: selectedDays, onToggle: (day, isSelected) {
                      setState(() {
                        if (isSelected) {
                          selectedDays.add(day);
                        } else {
                          selectedDays.remove(day);
                        }
                      });
                    }),
                    DayButton(text: "F", day: "Friday", selectedDays: selectedDays, onToggle: (day, isSelected) {
                      setState(() {
                        if (isSelected) {
                          selectedDays.add(day);
                        } else {
                          selectedDays.remove(day);
                        }
                      });
                    }),
                    DayButton(text: "S", day: "Saturday", selectedDays: selectedDays, onToggle: (day, isSelected) {
                      setState(() {
                        if (isSelected) {
                          selectedDays.add(day);
                        } else {
                          selectedDays.remove(day);
                        }
                      });
                    }),
                  ],
                ),
                OwnTextButton(text: "SAVE", callback: _saveReminders,
                backgroundColor: Color(0xff8E97FD),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
                    },
                    child: Text("NO THANKS",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18
                    ),
                    ),
                  ),
                )
              ],
            ),
          )
          ),
      ),
    );
  }
}

class DayButton extends StatelessWidget {
  const DayButton({
    super.key, 
    required this.text,
    required this.day,
    required this.selectedDays,
    required this.onToggle,
  });
  
  final String text;
  final String day;
  final List<String> selectedDays;
  final Function(String day, bool isSelected) onToggle;

  @override
  Widget build(BuildContext context) {
    bool isPressed = selectedDays.contains(day);
    
    return IconButton.outlined(
      style: ButtonStyle(
        backgroundColor: isPressed? WidgetStatePropertyAll(Color(0xff3F414E)) : null
      ),
      onPressed: () {
        onToggle(day, !isPressed);
      },
      icon: Text(text,
      style: TextStyle(
        color: isPressed ? Colors.white : null
      ),
      ),
    );
  }
}