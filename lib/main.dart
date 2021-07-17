import 'package:attendance_app/Register/Register_page.dart';
import 'package:attendance_app/getting_started_sreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
// import 'package:dcdg/dcdg.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Covenant University',
    theme: ThemeData(
        // primarySwatch: Colors.deepPurple[600],
        brightness: Brightness.dark,
        primaryColor: Colors.purpleAccent,
        accentColor: Colors.cyan[600],
        backgroundColor: Colors.deepPurple[900]),
    home: GettingStarted(),
  ));
}

// class FirstRoute extends StatefulWidget {
//   @override
//   _FirstRouteState createState() => _FirstRouteState();
// }

// class _FirstRouteState extends State<FirstRoute> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Covenant University'),
//           backgroundColor: Colors.deepPurple[400],
//         ),
//         body: SafeArea(
//             child: Container(
//                 width: double.infinity,
//                 height: MediaQuery.of(context).size.height,
//                 padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Hello There!",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 40),
//                         ),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         Text(
//                           "Thanks for coming to class, First time? please register.",
//                           textAlign: TextAlign.center,
//                           style:
//                               TextStyle(color: Colors.grey[700], fontSize: 15),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       height: MediaQuery.of(context).size.height / 3,
//                       decoration: BoxDecoration(
//                           image: DecorationImage(
//                               image: AssetImage('assets/Illustration.png'))),
//                     ),
//                     MaterialButton(
//                       minWidth: double.infinity,
//                       height: 60,
//                       onPressed: () {
//                         ThemeData.dark();
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => RegisterPage()));
//                       },
//                       color: Colors.deepPurple[400],
//                       shape: RoundedRectangleBorder(
//                           side: BorderSide(
//                             color: Colors.black,
//                           ),
//                           borderRadius: BorderRadius.circular(40)),
//                       child: Text(
//                         "Register",
//                         style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16,
//                             color: Colors.white70),
//                       ),
//                     ),
//                     // isLoading
//                     //     ? Center(
//                     //         child: CircularProgressIndicator(),
//                     //       )
//                     //     : SizedBox(),
//                   ],
//                 ))));
//   }
// }

class DialogBuilder {
  DialogBuilder(this.context);

  final BuildContext context;

  void showLoadingIndicator(String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              backgroundColor: Colors.black87,
              content: LoadingIndicator(text: text),
            ));
      },
    );
  }

  void hideOpenDialog() {
    Navigator.of(context).pop();
  }
}

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({this.text = ''});

  final String text;

  @override
  Widget build(BuildContext context) {
    var displayedText = text;

    return Container(
        padding: EdgeInsets.all(16),
        color: Colors.black87,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _getLoadingIndicator(),
              _getHeading(context),
              _getText(displayedText)
            ]));
  }

  Padding _getLoadingIndicator() {
    return Padding(
        child: Container(
            child: CircularProgressIndicator(strokeWidth: 3),
            width: 32,
            height: 32),
        padding: EdgeInsets.only(bottom: 16));
  }

  Widget _getHeading(context) {
    return Padding(
        child: Text(
          'Please wait …',
          style: TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.only(bottom: 4));
  }

  Text _getText(String displayedText) {
    return Text(
      displayedText,
      style: TextStyle(color: Colors.white, fontSize: 14),
      textAlign: TextAlign.center,
    );
  }
}
