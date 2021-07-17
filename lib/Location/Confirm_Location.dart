import 'package:attendance_app/Attendance/camera_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as Math;

class Courses {
  final String title;

  Courses(this.title);
}

class SecondRoute extends StatefulWidget {
  final List<Courses> todos;

  SecondRoute({Key? key, required this.todos}) : super(key: key);

  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
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
        title: Text('Courses'),
      ),
      body: ListView.builder(
        itemCount: widget.todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.todos[index].title),
            // When a user taps the ListTile, navigate to the DetailScreen.
            // Notice that you're not only creating a DetailScreen, you're
            // also passing the current todo through to it.
            onTap: () async {
              ThemeData.dark();
              // isLoading = true;
              // DialogBuilder(context)
              //     .showLoadingIndicator('Confirming Location...');
              await _condition();
              print(_distanceInMeters);
              if (_distanceInMeters > 10) {
                final snackBar = SnackBar(
                    content: Text('Your Location Has Been Confirmed!!!'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraScreen(),
                    // CameraScreen(),
                    // Pass the arguments as part of the RouteSettings. The
                    // DetailScreen reads the arguments from these settings.
                    settings: RouteSettings(
                      arguments: widget.todos[index],
                    ),
                  ),
                );
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: new Text('Why are you trying to stab?'),
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
          );
        },
      ),
    );
  }

  _getCurrentLocation() {
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
      // DialogBuilder(context).hideOpenDialog();
      print(_currentPosition.latitude);
      print(_currentPosition.longitude);
    });
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

  // void setState(Null Function() param0) {}
}
