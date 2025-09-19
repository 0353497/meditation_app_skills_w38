import 'package:flutter/material.dart';
import 'package:meditation_app/pages/sign_in_page.dart';
import 'package:meditation_app/providers/tab_bar_provider.dart';
import 'package:provider/provider.dart';

class WelcomeSleepView extends StatefulWidget {
  const WelcomeSleepView({
    super.key,
  });

  @override
  State<WelcomeSleepView> createState() => _WelcomeSleepViewState();
}

class _WelcomeSleepViewState extends State<WelcomeSleepView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TabBarProvider>().showTabBar(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff03174C),
      child: Stack(
        children: [
          Image.asset("assets/images/sleep/welcome_sleep_background.png"),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  spacing: 10,
                  children: [
                    Text("Welcome to Sleep",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xffE6E7F2),
                        fontWeight: FontWeight.bold,
                        fontSize: 32
                      ),
                    ),
                    Text("Explore the new king of sleep. It uses sound and visualisation to create perfect conditions for refreshing sleep.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xffE6E7F2),
                        fontSize: 16
                      ),
                    ),
                  ],
                ),
              ),
              Transform.scale(
                scale: 1,
                child: Image.asset("assets/images/sleep/welcome_sleep_birds.png", width: 350,)
                ),
              Center(child: OwnTextButton(text: "GET STARTED", callback: (){
                context.read<TabBarProvider>().changeCurrentSleepView(1);
                context.read<TabBarProvider>().showTabBar(true);
              }, backgroundColor: Color(0xff8E97FD),))
            ],
          )
        ],
      ),
    );
  }
}