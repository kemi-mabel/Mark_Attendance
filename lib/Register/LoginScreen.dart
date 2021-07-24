import 'package:attendance_app/Register/Signup_page.dart';
import 'package:attendance_app/utils/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:attendance_app/utils/validator.dart';

import 'Profile_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);
  final Color logoGreen = Color(0xff25bcbb);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  bool _isProcessing = false;
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            user: user,
            matnumber: '',
          ),
        ),
      );
    }
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: primaryColor,
        body: FutureBuilder(
            future: _initializeFirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Sign in to FRAMA and continue',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                  color: Colors.white, fontSize: 28),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Enter your student email and password below to continue to the FRAMA app and let the learning begin!',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                  color: Colors.white, fontSize: 14),
                            ),
                            SizedBox(height: 80),
                            _buildTextFieldEmail(
                                nameController, Icons.account_circle, 'Email'),
                            SizedBox(height: 20),
                            _buildTextFieldPassword(
                                passwordController, Icons.lock, 'Password'),
                            SizedBox(height: 30),
                            _isProcessing
                                ? CircularProgressIndicator()
                                : SizedBox(height: 30),
                            MaterialButton(
                              elevation: 0,
                              minWidth: double.maxFinite,
                              height: 50,
                              onPressed: () async {
                                _focusEmail.unfocus();
                                _focusPassword.unfocus();
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isProcessing = true;
                                  });
                                  User? user =
                                      await FireAuth.signInUsingEmailPassword(
                                    email: _emailTextController.text,
                                    password: _passwordTextController.text,
                                  );
                                  setState(() {
                                    _isProcessing = false;
                                  });
                                  if (user != null) {
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => ProfilePage(
                                        user: user,
                                        matnumber: '',
                                      ),
                                    ));
                                  }
                                }
                              },
                              color: Colors.blue,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(FontAwesomeIcons.school),
                                    SizedBox(width: 10),
                                    Text('Sign In',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16))
                                  ]),
                              textColor: Colors.white,
                            ),
                            SizedBox(height: 30),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Don't have an account?"),
                                  TextButton(
                                    // elevation: 0,
                                    // minWidth: double.maxFinite,
                                    // height: 50,
                                    onPressed: () {
                                      ThemeData.dark();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SignUp()));
                                    },
                                    // color: logoGreen,
                                    child: Text('Register',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16)),
                                    // textColor: Colors.white,
                                  )
                                ]),
                            SizedBox(height: 100),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: _buildFooterLogo(),
                            )
                          ],
                        ),
                      ),
                    ));
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }

  _buildFooterLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/culogo.png',
          height: 40,
        ),
        Text('Covenant University',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  _buildTextFieldEmail(
      TextEditingController controller, IconData icon, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: secondaryColor, border: Border.all(color: Colors.blue)),
      child: TextFormField(
        controller: controller,
        focusNode: _focusEmail,
        validator: (value) => Validator.validateEmail(email: value),
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white),
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
  }

  _buildTextFieldPassword(
      TextEditingController controller, IconData icon, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: secondaryColor, border: Border.all(color: Colors.blue)),
      child: TextFormField(
        controller: controller,
        focusNode: _focusPassword,
        validator: (value) => Validator.validatePassword(password: value),
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white),
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
