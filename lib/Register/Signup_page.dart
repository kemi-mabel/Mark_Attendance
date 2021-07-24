import 'dart:io';
import 'package:attendance_app/utils/firebase_auth.dart';
import 'package:attendance_app/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Profile_page.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _focusName.unfocus();
          _focusEmail.unfocus();
          _focusPassword.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('SIGN UP'),
          ),
          body: Form(
            key: _registerFormKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Welcome, Register with your correct matric number",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[100],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    controller: _nameTextController,
                    focusNode: _focusName,
                    validator: (value) => Validator.validateName(
                      matric_no: value,
                    ),
                    decoration: InputDecoration(
                      hintText: "Matric No",
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _emailTextController,
                    focusNode: _focusEmail,
                    validator: (value) => Validator.validateEmail(
                      email: value,
                    ),
                    decoration: InputDecoration(
                      hintText: "Student Email",
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _passwordTextController,
                    focusNode: _focusPassword,
                    obscureText: true,
                    validator: (value) => Validator.validatePassword(
                      password: value,
                    ),
                    decoration: InputDecoration(
                      hintText: "Password",
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50.0),
                  _isProcessing ? CircularProgressIndicator() : Row(),
                  SizedBox(height: 50.0),
                  MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 60,
                    color: Colors.blue[900],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    onPressed: () async {
                      setState(() {
                        _isProcessing = true;
                      });
                      if (_registerFormKey.currentState!.validate()) {
                        User? user = await FireAuth.registerUsingEmailPassword(
                          name: _nameTextController.text,
                          email: _emailTextController.text,
                          password: _passwordTextController.text,
                          //validate image
                        );
                        setState(() {
                          _isProcessing = false;
                        });
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => RegisterCamera(
                        //             matnumber:
                        //                 _nameTextController.text.toUpperCase())));

                        if (user != null) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(
                                  user: user,
                                  matnumber:
                                      _nameTextController.text.toUpperCase()),
                            ),
                            ModalRoute.withName('/'),
                          );
                        }
                      }
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
