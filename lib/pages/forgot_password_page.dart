import 'package:flutter/material.dart';
import 'package:meditation_app/pages/have_send_email_page.dart';
import 'package:meditation_app/pages/sign_in_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  var outlineInputBorder =   OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Colors.transparent,
        width: 2,
        style: BorderStyle.none
      )
    );
  final RegExp _emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  String? _emailError;

  void _validateEmail(String value) {
      setState(() {
        if (value.isEmpty) {
          _isEmailValid = false;
          _emailError = 'Email is required';
        } else if (!_emailRegex.hasMatch(value)) {
          _isEmailValid = false;
          _emailError = 'Please enter a valid email address';
        } else {
          _isEmailValid = true;
          _emailError = null;
        }
      });
    }

  bool _isEmailValid = false;

  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Forgot Password",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold
                ),
              ),
              Column(
                spacing: 20,
                children: [
                  TextField(
                     controller: _emailController,
                     onChanged: _validateEmail,
                     keyboardType: TextInputType.emailAddress,
                     decoration: InputDecoration(
                       border: outlineInputBorder,
                       enabledBorder: outlineInputBorder,
                       fillColor: const Color(0xffF2F3F7),
                       hintText: "Email address",
                       hintStyle: TextStyle(
                         color: const Color(0xff7583CA)
                       ),
                       errorText: _emailError,
                       filled: true,
                       suffixIcon: _isEmailValid 
                           ? Icon(Icons.check, color: Colors.green, size: 24)
                           : null,
                     ),
                   ),
                   OwnTextButton(text: "CONFIRM", callback: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HaveSendEmailPage(email: _emailController.text))))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}