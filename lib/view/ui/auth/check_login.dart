import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kpi_app/view/utils/loading_animation.dart';

class CheckLogIn extends StatefulWidget {
  const CheckLogIn({Key? key}) : super(key: key);

  @override
  State<CheckLogIn> createState() => _CheckLogInState();
}

class _CheckLogInState extends State<CheckLogIn> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: loadingAnimation(),
      ),
    );
  }

  checkLogin() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      try {
        if (user == null) {
          Navigator.of(context).pushReplacementNamed("/login");
        } else {
          if (user.email == "officeinfo1197@gmail.com") {
            Navigator.of(context).pushReplacementNamed("/dashboard/admin");
          } else {
            Navigator.of(context).pushReplacementNamed("/dashboard/user");
          }
        }
      } catch (e) {
        print(e.toString());
      }
    });
  }
}
