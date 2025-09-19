import 'package:flutter/material.dart';
import 'package:meditation_app/pages/views/normal_sleep_view.dart';
import 'package:meditation_app/pages/views/sleep_music_view.dart';
import 'package:meditation_app/pages/views/welcome_sleep_view.dart';
import 'package:meditation_app/providers/tab_bar_provider.dart';
import 'package:provider/provider.dart';

class SleepView extends StatefulWidget {
  const SleepView({super.key});

  @override
  State<SleepView> createState() => _SleepViewState();
}

class _SleepViewState extends State<SleepView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TabBarProvider>(
      builder: (context, tabBarProvider, child) {
        if (tabBarProvider.currentSleepview == 0) return WelcomeSleepView();
        if (tabBarProvider.currentSleepview == 1) return NormalSleepView();
        if (tabBarProvider.currentSleepview == 2) return SleepMusicView();
        return NormalSleepView();
      },
    );
  }
}
