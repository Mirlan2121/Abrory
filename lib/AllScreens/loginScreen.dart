import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nam_po_puti/AllScreens/registrationScreen.dart';
import 'package:nam_po_puti/main.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen = "login";

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 65.0,
              ),
              Image(
                image: AssetImage("images/logo.png"),
                width: 390.0,
                height: 250.0,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 35.0,
              ),
              Text(
                "Войти как водитель",
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(fontSize: 14.0),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          )),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(fontSize: 14.0),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          )),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    RaisedButton(
                      color: Colors.yellow,
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 18.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(24.0)),
                      onPressed: () {
                        if (!emailTextEditingController.text.contains("@")) {
                          displayToastMessage(
                              "Email address is not valid", context);
                        } else if (passwordTextEditingController.text.length <
                            7) {
                          displayToastMessage(
                              "Password must be at least 6 characters",
                              context);
                        } else {
                          loginAndAuthenticateUser(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
              TextButton(
                child: Text(
                  "Do not have an account? Register here.",
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RegistrationScreen.idScreen, (route) => false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginAndAuthenticateUser(BuildContext context) async
  {
    final User? firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
      email: emailTextEditingController.text,
      password: passwordTextEditingController.text,
    )
            .catchError((errMsg) {
      displayToastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;


  }
}
