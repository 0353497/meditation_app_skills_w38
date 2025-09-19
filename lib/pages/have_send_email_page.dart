import 'package:flutter/material.dart';
import 'package:meditation_app/pages/home_page.dart';
import 'package:meditation_app/pages/sign_in_page.dart';

class HaveSendEmailPage extends StatelessWidget {
  const HaveSendEmailPage({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 30,
            children: [
              SizedBox(),
              Text("We have send an email to $email", 
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold
              ),
              ),
              OwnTextButton(text: "CONTINUE", callback: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage())))
            ],
          ),
        ),
      ),
    );
  }
}