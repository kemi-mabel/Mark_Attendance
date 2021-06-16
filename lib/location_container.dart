// import 'package:attendance_app/camera.dart';
import 'package:attendance_app/camerascreen/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

// ignore: import_of_legacy_library_into_null_safe
// import 'package:camera/camera.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
// dorcas 6.671543056185375, 3.157386742327303
// eie 6.675805996447509, 3.162605066975611
// cucrid 6.672626635579447, 3.161159132518136

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Location"),
        ),
        body: Container(
          child: Container(
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // if (isLocationSet)
                  //   Text(
                  //       "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
                  ElevatedButton(
                    child: Text("Get location"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                // _getCurrentLocation();
                                confirmLocation(),
                          ));
                    },
                  )
                ]),
          ),
        ));
  }
}

class confirmLocation extends StatelessWidget {
  final double _latitudeForCalculation = 6.671543056185375;
  final _longitudeForCalculation = 3.157386742327303;
  Position _currentPosition = null as Position;
  bool isLocationSet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Location Confirmation"),
        ),
        body: Container(
            child: Container(
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _getCurrentLocation(),
                      if (isLocationSet)
                        Text(
                            "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
                      ElevatedButton.icon(
                          icon: Icon(
                            Icons.camera_alt,
                          ),
                          label: Text('Next'),
                          onPressed: () {
                            ThemeData.dark();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CameraScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.purple,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                          ))
                    ]))));
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState() {
        _currentPosition = position;
        isLocationSet = true;
      }
    }).catchError((e) {
      print(e);
    });
  }

  _condition() {
    setState() {
      double _distanceInMeters = Geolocator.distanceBetween(
        _latitudeForCalculation,
        _longitudeForCalculation,
        _currentPosition.latitude,
        _currentPosition.longitude,
      );
      print(_distanceInMeters);

      // if (_distanceInMeters <51)  {
      //     msg = 'We have learned FlutterRaised button example.';
      //   } else {
      //     msg = 'Flutter RaisedButton Example';
      //   }
    }
  }
}
