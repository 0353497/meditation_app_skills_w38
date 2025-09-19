import 'package:flutter/material.dart';
import 'package:meditation_app/pages/onboarding/onboarding_choose_topic_page.dart';
import 'package:meditation_app/pages/sign_in_page.dart';
import 'package:meditation_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class OnboardingWelcomePage extends StatelessWidget {
  const OnboardingWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Color(0xff8E97FD),
        appBar: AppBar(
          title: Image.asset("assets/images/focus_skills_logo_white.png", width: 160,),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  spacing: 10,
                  children: [
                    Text("Hi ${context.watch<UserProvider>().username},",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 32
                      ),
                    ),
                    Text("Welcome to Focus Skills",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24
                      ),
                    ),
                    Text("Explore the app and find some peace of mind to prepare for meditation",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    Image.asset(
                    "assets/images/mediation_welcome_bg.png",
                    fit: BoxFit.cover,
                    alignment: Alignment(0, -.9),
                    width: double.maxFinite,
                    ),
                    Align(
                      alignment: Alignment(0, 1),
                      child: Image.asset("assets/images/meditate_yoga.png", ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 40,),
              OwnTextButton(
                text: "GET STARTED",
              callback: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => OnboardingChooseTopicPage())),
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              ),
              SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }
}