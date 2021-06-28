import 'package:attendance_app/Register_page.dart';
import 'package:attendance_app/camerascreen/camera_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'Location_page.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as Math;

class Todo {
  final String title;

  Todo(this.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Covenant University',
    theme: ThemeData(
        // primarySwatch: Colors.deepPurple[600],
        brightness: Brightness.light,
        primaryColor: Colors.deepPurple[600],
        accentColor: Colors.cyan[600],
        backgroundColor: Colors.white),
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatefulWidget {
  @override
  _FirstRouteState createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  // dorcas 6.671543056185375, 3.157386742327303
// eie 6.675805996447509, 3.162605066975611
// cucrid 6.672626635579447, 3.161159132518136
//eie  6.675905, 3.162383

  final double _latitudeForCalculation = 6.675805996447509;

  final double _longitudeForCalculation = 3.162605066975611;

  Position _currentPosition = null as Position;

  bool isDistanceSet = false;
  bool isLocationSet = false;

  bool isLoading = false;
  double _distanceInMeters = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome!'),
          backgroundColor: Colors.deepPurple[400],
        ),
        body: SafeArea(
            child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Hello There!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Thanks for coming to class, First time? please register.",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 15),
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/Illustration.png'))),
                    ),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        ThemeData.dark();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      color: Colors.deepPurple[400],
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(40)),
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white70),
                      ),
                    ),
                    isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : SizedBox(),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () async {
                        isLoading = true;
                        // DialogBuilder(context)
                        //     .showLoadingIndicator('Getting Location...');
                        await _condition();
                        print(_distanceInMeters);
                        isLoading = false;
                        if (_distanceInMeters > 10) {
                          final snackBar = SnackBar(
                              content:
                                  Text('Your Location Has Been Confirmed!!!'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondRoute(
                                      todos: List.generate(
                                        9,
                                        (i) => Todo(
                                          'EIE 52$i',
                                        ),
                                      ),
                                    )),
                          );
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title:
                                      new Text('Why are you trying to stab?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: new Text("I'LL GO TO CLASS"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                      color: Colors.lightBlue[900],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      child: Text(
                        "Attendance",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ))));
  }

  _getCurrentLocation() {
    // setState(() {
    //   isLoading = true;
    // });
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        isLocationSet = true;
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future _condition() async {
    await _getCurrentLocation();
    // print(_currentPosition.latitude);

    setState(() {
      _distanceInMeters = getDistanceFromLatLonInMetres(
          _latitudeForCalculation,
          _longitudeForCalculation,
          _currentPosition.latitude,
          _currentPosition.longitude);
      // _distanceInMeters = Geolocator.distanceBetween(
      //   _latitudeForCalculation,
      //   _longitudeForCalculation,
      //   _currentPosition.latitude,
      //   _currentPosition.longitude,
      // );
      print(_currentPosition.latitude);
      print(_currentPosition.longitude);

      // print(_distanceInMeters);
      // if (_distanceInMeters > 70) {
      //   isDistanceSet = true;
      // }
      // setState(() {
      //   isLoading = false;
      // });
    });
    // setState(() {
    //   isLoading = false;
    // });
  }

  double getDistanceFromLatLonInMetres(lat1, lon1, lat2, lon2) {
    var R = 6371000; // Radius of the earth in metres
    var dLat = deg2rad(lat2 - lat1); // deg2rad below
    var dLon = deg2rad(lon2 - lon1);
    var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(deg2rad(lat1)) *
            Math.cos(deg2rad(lat2)) *
            Math.sin(dLon / 2) *
            Math.sin(dLon / 2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    var d = R * c;
    return d;
  }

  double deg2rad(deg) {
    return deg * (Math.pi / 180);
  }
}

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

class SecondRoute extends StatelessWidget {
  final List<Todo> todos;

  SecondRoute({Key? key, required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            // When a user taps the ListTile, navigate to the DetailScreen.
            // Notice that you're not only creating a DetailScreen, you're
            // also passing the current todo through to it.
            onTap: () async {
              ThemeData.dark();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CameraScreen(),
                  // Pass the arguments as part of the RouteSettings. The
                  // DetailScreen reads the arguments from these settings.
                  settings: RouteSettings(
                    arguments: todos[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
