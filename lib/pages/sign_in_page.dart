
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:meditation_app/pages/forgot_password_page.dart';
import 'package:meditation_app/pages/home_page.dart';
import 'package:meditation_app/pages/onboarding/onboarding_welcome_page.dart';
import 'package:meditation_app/pages/sign_up_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  
  String? _emailError;
  String? _passwordError;

  final RegExp _emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  
  final RegExp _passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$');

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

  void _validatePassword(String value) {
    setState(() {
      if (value.isEmpty) {
        _isPasswordValid = false;
        _passwordError = 'Password is required';
      } else if (!_passwordRegex.hasMatch(value)) {
        _isPasswordValid = false;
        _passwordError = 'Password must be at least 8 characters with uppercase, lowercase, and number';
      } else {
        _isPasswordValid = true;
        _passwordError = null;
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder =
    OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Colors.transparent,
        width: 2,
        style: BorderStyle.none
      )
    );
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        leadingWidth: 100,
        leading: IconButton.outlined(
          padding: EdgeInsetsDirectional.all(16),
          alignment: Alignment.topLeft,
          style: ButtonStyle(
            alignment: Alignment.center,
            side: WidgetStatePropertyAll(
              BorderSide(
              width: 1,
              color: Colors.grey.withAlpha(100)
            ))
          ),
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back)
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset("assets/images/in_bg.png", color: const Color(0xffFAF8F5),)
            ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(),
                Text("WELCOME BACK!",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 32
                ),
                ),
                Column(
                  spacing: 20,
                  children: [
                    OwnTextButton(
                    callback: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OnboardingWelcomePage())),
                      leading: Text("f",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      text: "CONTINUE WITH FACEBOOK",
                    ),
                    OwnTextButton(
                    callback: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OnboardingWelcomePage())),
                    leading: Image.asset("assets/images/google_logo.png", width: 32,),
                    text: "CONTINUE WITH GOOGLE",
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    outlineColor: Colors.grey.withAlpha(100),
                    ),
                    SizedBox(),
                    GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => SignInPage()));
                          },
                          child: Text("OR LOG IN WITH EMAIL",
                            style: TextStyle(
                              color: const Color(0xff8E97FD),
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),
                          ),
                        ),
                  ],
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                spacing: 20,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          filled: true,
                          suffixIcon: _isEmailValid 
                              ? Icon(Icons.check, color: Colors.green, size: 24)
                              : null,
                        ),
                      ),
                      if (_emailError != null)
                        Padding(
                          padding: EdgeInsets.only(top: 8, left: 12),
                          child: Text(
                            _emailError!,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SignInPasswordField(
                        outlineInputBorder: outlineInputBorder,
                        controller: _passwordController,
                        onChanged: _validatePassword,
                        isValid: _isPasswordValid,
                      ),
                      if (_passwordError != null)
                        Padding(
                          padding: EdgeInsets.only(top: 8, left: 12),
                          child: Text(
                            _passwordError!,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                  OwnTextButton(
                    text: "LOG IN",
                    backgroundColor: Color(0xff8E97FD),
                    callback: () {
                      if (_isEmailValid && _isPasswordValid) {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
                      }
                  },),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ForgotPasswordPage())),
                    child: Text("Forgot Password?",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                ],
              ),
               Text.rich(
                  TextSpan(
                    text: "ALREADY HAVE AN ACCOUNT? ",
                     style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),
                    children: [
                      TextSpan(
                        text: "SIGN UP",
                        recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpPage())),
                         style: TextStyle(
                              color: const Color(0xff8E97FD),
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),
                      )
                    ]
                  )
                 )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SignInPasswordField extends StatefulWidget {
  const SignInPasswordField({
    super.key,
    required this.outlineInputBorder,
    required this.controller,
    required this.onChanged,
    required this.isValid,
  });

  final OutlineInputBorder outlineInputBorder;
  final TextEditingController controller;
  final Function(String) onChanged;
  final bool isValid;

  @override
  State<SignInPasswordField> createState() => _SignInPasswordFieldState();
}

class _SignInPasswordFieldState extends State<SignInPasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: true,
      decoration: InputDecoration(
        border: widget.outlineInputBorder,
        enabledBorder: widget.outlineInputBorder,
        fillColor: const Color(0xffF2F3F7),
        hintText: "Password",
        hintStyle: TextStyle(color: const Color(0xff7583CA)),
        filled: true,
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.isValid)
              Icon(Icons.check, color: Colors.green, size: 24),
          ],
        ),
      ),
    );
  }
}

class OwnTextButton extends StatelessWidget {
  const OwnTextButton({
    super.key, this.leading, required this.text, this.foregroundColor = const Color(0xffF6F1FB), this.backgroundColor =const Color(0xff7583CA), this.outlineColor = const Color.fromRGBO(124, 77, 255, 1), required this.callback,
  });
  final Widget? leading;
  final String text;
  final Color foregroundColor;
  final Color backgroundColor;
  final Color outlineColor;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 20,
      height: 60,
      child: TextButton(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(foregroundColor),
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
        side: WidgetStatePropertyAll(BorderSide(color: outlineColor))
      ),
      onPressed: () {
        callback.call();
        debugPrint("pressed button");
        },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ?leading,
          if (leading != null) SizedBox(width: 30,),
          Text(text,
          style: TextStyle(
            fontSize: 18
          ),
          )
        ],
      ),
      ),
    );
  }
}