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
  // final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
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
              // ThemeData.dark();
              // setState(() {
              //   isLoading = true;
              // });
              DialogBuilder(context)
                  .showLoadingIndicator('Confirming Location...');
              await _condition();
              DialogBuilder(context).hideOpenDialog();
              if (_distanceInMeters > 10) {
                // setState(() {
                //   isLoading = false;
                // });
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

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.medium,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        // isLocationSet = true;
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future _condition() async {
    // print(_currentPosition.latitude);
    await _getCurrentLocation();

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
    print(_distanceInMeters);
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
