import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/screens/signup_screen.dart';
import 'package:todo_list_app/utils/color_utils.dart';

import '../reusable_widgets/reusable_widgets.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(colors: [
          hexStringToColor("CB2B93"),
          hexStringToColor("9546C4"),
          hexStringToColor("5E61F4")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Form(
                child: Column(
                    children: [
                      reusableTextField("Email", Icons.email, false, "Please enter email", _emailTextController),

                      SizedBox(height: 16,),

                      reusableTextField("Password", Icons.password, true, "Please enter password", _passwordTextController),

                      SizedBox(height: 20,),

                      signInSignUpButton(context, true, () {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text)
                            .then ((value) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                        }).onError((error, stackTrace) {
                          print("Error ${error.toString()}");
                        });
                      }),
                      signUpOption()
                    ]
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
          style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ),
      ],
    );
  }
}
