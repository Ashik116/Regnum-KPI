import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kpi_app/view/utils/background_unlogged.dart';
import 'package:kpi_app/view/utils/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  String username = "";
  String password = "";
  bool _passwordHide = true ;
  var userInfo;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BackgroundUnlogged(
      child: SingleChildScrollView(
          child: SafeArea(
        child: Column(
          children: [
            Column(
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.06,
                ),
                Container(
                  height: size.height * .15,
                  child: Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                              text: "Welcome",
                              style: TextStyle(
                                fontSize: 45,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Alice-Regular',
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          width: size.width * 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    username = value;
                                  });
                                },
                                keyboardType: TextInputType.emailAddress,
                                //obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'User Email',
                                  labelText: "Email",
                                  suffixIcon: Icon(
                                    Icons.email_outlined,
                                    color: Colors.lightGreen.shade500,
                                  ),
                                  border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                ),
                                // validator: (value) {
                                //   if (value != null) {
                                //     return "Enter Email";
                                //   } else if (!RegExp(
                                //           r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                //       .hasMatch(value!)) {
                                //     return "Invalid Mail Address";
                                //   } else
                                //     return null;
                                // },
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              TextFormField(
                                obscureText: _passwordHide,
                                onChanged: (value) {
                                  setState(() {
                                    password = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  //hintText: _passWord,
                                  labelText: "Password",
                                  prefixIcon: Icon(Icons.vpn_key_outlined),
                                    suffixIcon: IconButton(
                                      color: Colors.lightGreen.shade500,
                                      icon: _passwordHide ? Icon(Icons.visibility_rounded) : Icon(Icons.visibility_off_rounded),
                                      onPressed: () {
                                        setState(() {
                                          _passwordHide = !_passwordHide;
                                        });
                                      },
                                    ),
                                  border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                ),
                              ),
                              SizedBox(
                                height: size.height * .01,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: size.height * .045,
                            ),
                            CustomButton(
                              label: 'Sign in',
                              isLoading: true,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  logIn();
                                }
                              },
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            Column(
                              children: [
                                Container(
                                  child: GestureDetector(
                                    onTap: () async {
                                      Navigator.of(context)
                                          .pushNamed("/signup/info");
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                              text: 'Regnum KPI',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Alice-Regular',
                                              )),
                                          TextSpan(
                                              text: ' Join',
                                              style: TextStyle(
                                                color:
                                                    Colors.lightGreen.shade800,
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.bold,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * .03,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }

  logIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: username.toString(), password: password.toString());
      late SharedPreferences sharedPreferences ;


      if (userCredential.user == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        if (username == "officeinfo1197@gmail.com") {
          Navigator.of(context).pushReplacementNamed("/dashboard/admin");
        } else {
          Navigator.of(context).pushReplacementNamed("/dashboard/user");
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        snackBarMsg("User not found");
      } else if (e.code == 'wrong-password') {
        snackBarMsg("Wrong password");
      } else {
        snackBarMsg("Something is wrong");
      }
    }
  }

  void snackBarMsg(loginErrorMessage) {
    final snackBar = SnackBar(
      content: Text(
        loginErrorMessage.toString(),
        style: const TextStyle(color: Colors.red),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
