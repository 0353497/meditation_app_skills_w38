import 'package:flutter/material.dart';
import 'package:meditation_app/pages/start_page.dart';
import 'package:meditation_app/providers/tab_bar_provider.dart';
import 'package:meditation_app/providers/user_provider.dart';
import 'package:meditation_app/providers/audio_data_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => TabBarProvider()),
        ChangeNotifierProvider(create: (_) => AudioDataProvider()),
      ],
      child: const MaterialApp(
        home: StartPage()
      ),
    );
  }
}
