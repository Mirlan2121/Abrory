import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:flutter/material.dart';
import 'package:nam_po_puti/AllScreens/loginScreen.dart';
import 'package:nam_po_puti/AllScreens/mainScreen.dart';
import 'package:nam_po_puti/main.dart';

class RegistrationScreen extends StatelessWidget {
  static const String idScreen = "register";

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
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
              SizedBox(height: 65.0,),
              Image(image: AssetImage("images/logo.png"),
                width: 390.0,
                height: 250.0,
                alignment: Alignment.center,),
              SizedBox(
                height: 35.0,
              ),
              Text(
                "Зарегистрироваться как водитель",
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,
              ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: TextStyle(
                              fontSize: 14.0
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          )
                      ),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                              fontSize: 14.0
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          )
                      ),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: "Phone",
                          labelStyle: TextStyle(
                              fontSize: 14.0
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          )
                      ),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),

                    SizedBox(height: 1.0,),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                              fontSize: 14.0
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          )
                      ),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 30.0,),
                    RaisedButton(
                      onPressed: () {
                        if (nameTextEditingController.text.length < 4) {
                          displayToastMessage("Name must be at least 3 characters", context);
                        }else if(!emailTextEditingController.text.contains("@")){
                          displayToastMessage("Email address is not valid", context);
                        }else if(phoneTextEditingController.text.isEmpty){
                          displayToastMessage("Phone Number is not valid ", context);
                        }else if(passwordTextEditingController.text.length < 7){
                          displayToastMessage("Password must be at least 6 characters", context);
                        }else{
                          registerNewUser(context);
                        }
                        registerNewUser(context);
                      },
                      color: Colors.yellow,
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Creare account",
                            style: TextStyle(
                                fontSize: 18.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(24.0)
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                child: Text(
                  "Already have an account? Login here",
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.idScreen, (route) => false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async {
    final User? firebaseUser = (await _firebaseAuth
      .createUserWithEmailAndPassword(
      email: emailTextEditingController.text,
      password: passwordTextEditingController.text,
    ).catchError((errMsg){
      displayToastMessage("Error: "+ errMsg.toString(), context);
    })).user;

    if (firebaseUser != null) {
          Map userDataMap = {
            "name": nameTextEditingController.text.trim(),
            "email": emailTextEditingController.text.trim(),
            "phone": phoneTextEditingController.text.trim(),
          };
           usersRef.child(firebaseUser.uid).set(userDataMap);
           displayToastMessage("Congratulations, your account has been created.", context);
           Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
    } else {
      displayToastMessage("New user has not been created", context);
    }
  }
}

displayToastMessage(String message, BuildContext context){
  Fluttertoast.showToast(msg: message);
}
  