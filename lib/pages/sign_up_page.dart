import 'package:flutter/material.dart';
import 'package:meditation_app/pages/onboarding/onboarding_welcome_page.dart';
import 'package:meditation_app/pages/sign_in_page.dart';
import 'package:meditation_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isUsernameValid = false;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  
  String? _usernameError;
  String? _emailError;
  String? _passwordError;

  final RegExp _emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  
  final RegExp _passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$');

  void _validateUsername(String value) {
    setState(() {
      if (value.isEmpty) {
        _isUsernameValid = false;
        _usernameError = 'Username is required';
      } else {
        _isUsernameValid = true;
        _usernameError = null;
      }
    });
  }

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
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
            color: Colors.transparent, width: 2, style: BorderStyle.none));
    
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: 100,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        leading: IconButton.outlined(
          padding: EdgeInsetsDirectional.all(16),
          alignment: Alignment.topLeft,
          style: ButtonStyle(
              alignment: Alignment.center,
              side: WidgetStatePropertyAll(BorderSide(
                  width: 1, color: Colors.grey.withAlpha(100)))),
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                "assets/images/in_bg.png",
                color: const Color(0xffFAF8F5),
              )),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(),
                Text(
                  "Create your account",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                ),
                Column(
                  spacing: 20,
                  children: [
                    OwnTextButton(
                      callback: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OnboardingWelcomePage())),
                      leading: Text(
                        "f",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      text: "CONTINUE WITH FACEBOOK",
                    ),
                    OwnTextButton(
                      callback: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OnboardingWelcomePage())),
                      leading: Image.asset(
                        "assets/images/google_logo.png",
                        width: 32,
                      ),
                      text: "CONTINUE WITH GOOGLE",
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      outlineColor: Colors.grey.withAlpha(100),
                    ),
                    SizedBox(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => SignInPage()));
                      },
                      child: Text(
                        "OR LOG IN WITH EMAIL",
                        style: TextStyle(
                            color: const Color(0xff8E97FD),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _usernameController,
                          onChanged: _validateUsername,
                          decoration: InputDecoration(
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            fillColor: const Color(0xffF2F3F7),
                            hintText: "Username",
                            hintStyle: TextStyle(color: const Color(0xff7583CA)),
                            filled: true,
                            suffixIcon: _isUsernameValid 
                                ? Icon(Icons.check, color: Colors.green, size: 24)
                                : null,
                          ),
                        ),
                        if (_usernameError != null)
                          Padding(
                            padding: EdgeInsets.only(top: 8, left: 12),
                            child: Text(
                              _usernameError!,
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
                        TextField(
                          controller: _emailController,
                          onChanged: _validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            fillColor: const Color(0xffF2F3F7),
                            hintText: "Email address",
                            hintStyle: TextStyle(color: const Color(0xff7583CA)),
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
                        PasswordField(
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
                        PrivacyPolicy(),
                      ],
                    ),
                    OwnTextButton(
                      text: "GET STARTED",
                      backgroundColor: Color(0xff8E97FD),
                      callback: () {
                        if (_isUsernameValid && _isEmailValid && _isPasswordValid) {
                          final userprov = context.read<UserProvider>();
                          userprov.changeEmail(_emailController.text);
                          userprov.changeUserName(_usernameController.value.text);
                          Navigator.push(context, MaterialPageRoute(builder: (_) => OnboardingWelcomePage()));
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
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
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: _obscureText,
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
            IconButton(
              icon: !_obscureText ? Icon(
                Icons.visibility,
                color: Colors.black,
              ) : Image.asset("assets/images/icons/hidden.png", width: 24,),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({
    super.key,
  });


  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  bool hasReadPolicy = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(
            text: "i have read the ",
            style: TextStyle(
              color: Colors.grey
            ),
            children: [
              TextSpan(
                text: "Privace Policy",
                style: TextStyle(
                  color: Color(0xff8E97FD)
                )
              )
            ]
          ),
        ),
        Transform.scale(
          scale: 1.3,
          child: Checkbox(
            side: BorderSide(
              color: Colors.grey,
              width: 2
            ),
            value: hasReadPolicy,
            onChanged: (value) {
            setState(() {
              hasReadPolicy = !hasReadPolicy;
            });
          },),
        )
      ],
    );
  }
}
