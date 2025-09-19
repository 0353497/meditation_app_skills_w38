import 'package:flutter/material.dart';
import 'package:meditation_app/pages/sign_in_page.dart';
import 'package:meditation_app/pages/sign_up_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffF9F0E3),
        centerTitle: true,
        title: SizedBox(
          width: 200,
          child: Image.asset("assets/images/focus_skills_logo_grey_text.png",
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
            Align(
              alignment: Alignment(0, -1.9),
              child: Image.asset("assets/images/welcome_bg.png",
              color: Color(0xffF9F0E3),
              fit: BoxFit.cover,
              ),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("assets/images/lounch_welcome.png",
                width: MediaQuery.of(context).size.width - 100,
              ),
              Column(
                spacing: 20,
                children: [
                  Text("Enjoy Focus Skills",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.black
                    ),
                  ),
                  Text("Thousand of people are using Focus Skills\n for meditation",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff8E97FD)
                  ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 20,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 60,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(const Color(0xff8E97FD)),
                        foregroundColor: WidgetStatePropertyAll(const Color(0xffF6F1FB))
                      ),
                      onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpPage()));
                    },
                    child: Text("SIGN UP")
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => SignInPage()));
                    },
                    child: Text("ALREADY HAVE AN ACCOUNT? LOG IN",
                      style: TextStyle(
                        color: const Color(0xff8E97FD)
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}