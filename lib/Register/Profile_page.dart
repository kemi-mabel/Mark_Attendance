import 'package:attendance_app/Location/Confirm_Location.dart';
import 'package:attendance_app/Register/LoginScreen.dart';
import 'package:attendance_app/Registration/Register_camera.dart';
import 'package:attendance_app/utils/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  final String matnumber;

  const ProfilePage({required this.user, required this.matnumber});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isSendingVerification = false;
  bool _isSigningOut = false;
  late User _currentUser;
  late String _matNumber;

  @override
  void initState() {
    _currentUser = widget.user;
    _matNumber = widget.matnumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'NAME: ${_currentUser.displayName}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 16.0),
            Text(
              'EMAIL: ${_currentUser.email}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 16.0),
            _currentUser.emailVerified
                ? Text(
                    'Email verified',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.green),
                  )
                : Text(
                    'Email not verified',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.red),
                  ),
            SizedBox(height: 16.0),
            _isSendingVerification
                ? CircularProgressIndicator()
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _isSendingVerification = true;
                          });
                          await _currentUser.sendEmailVerification();
                          setState(() {
                            _isSendingVerification = false;
                          });
                        },
                        child: Text('Verify email'),
                      ),
                      SizedBox(width: 8.0),
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () async {
                          User? user = await FireAuth.refreshUser(_currentUser);

                          if (user != null) {
                            setState(() {
                              _currentUser = user;
                            });
                          }
                        },
                      ),
                    ],
                  ),
            SizedBox(height: 16.0),
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              height: 60,
              color: Colors.blue[900],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              onPressed: () {
                // ThemeData.dark();
                // if (_nameTextController.text.isNotEmpty)  {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterCamera(
                            matnumber: _matNumber.toUpperCase())));
                // } else {
                //   final snackBar =
                //       SnackBar(content: Text('INPUT MATRIC NUMBER'));
                //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text(
                "Register Face Picture",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white70),
              ),
            ),
            SizedBox(height: 25.0),
            MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                height: 60,
                color: Colors.blue[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPressed: () {
                  // ThemeData.dark();
                  // if (_nameTextController.text.isNotEmpty)  { /
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SecondRoute(
                                todos: List.generate(
                                  9,
                                  (i) => Courses(
                                    'EIE 52$i',
                                  ),
                                ),
                              )));
                },
                child: Text(
                  "Take Attendance",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white70),
                )),
            _isSigningOut
                ? CircularProgressIndicator()
                : SizedBox(height: 25.0),
            MaterialButton(
                // minWidth: MediaQuery.of(context).size.width,
                // height: 60,
                color: Colors.red[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () async {
                  setState(() {
                    _isSigningOut = true;
                  });
                  await FirebaseAuth.instance.signOut();
                  setState(() {
                    _isSigningOut = false;
                  });
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                child: Text(
                  'Sign out',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white70),
                )
                // style: ElevatedButton.styleFrom(
                //   primary: Colors.red,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(30),
                //   ),
                // ),
                ),
          ],
        ),
      ),
    );
  }
}
