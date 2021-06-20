import 'package:attendance_app/camerascreen/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  // late Position _currentPosition;
  // bool isLocationSet = false;
  // dorcas 6.671543056185375, 3.157386742327303
// eie 6.675805996447509, 3.162605066975611
// cucrid 6.672626635579447, 3.161159132518136

  final double _latitudeForCalculation = 6.675805996447509;
  final _longitudeForCalculation = 3.162605066975611;
  Position _currentPosition = null as Position;
  bool isLocationSet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (isLocationSet)
              Text(
                  "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
            TextButton(
              child: Text("Get location"),
              onPressed: () {
                _getCurrentLocation();
                _condition();
              },
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.camera_alt,
                    ),
                    label: Text('Next'),
                    onPressed: () async {
                      //   WidgetsFlutterBinding.ensureInitialized();
                      //   // Obtain a list of the available cameras on the device.
                      //   final cameras = await availableCameras();
                      //   // Get a specific camera from the list of available cameras.
                      //   final firstCamera = cameras.first;
                      ThemeData.dark();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  // TakePictureScreen(camera: firstCamera)));
                                  CameraScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                    )))
          ],
        ),
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

  _condition() {
    setState() {
      double _distanceInMeters = Geolocator.distanceBetween(
        _latitudeForCalculation,
        _longitudeForCalculation,
        _currentPosition.latitude,
        _currentPosition.longitude,
      );
      print(_distanceInMeters);

      // if (_distanceInMeters <50)  {
      //     msg = 'We have learned FlutterRaised button example.';
      //   } else {
      //     msg = 'Flutter RaisedButton Example';
      //   }
    }
  }
  //  _condition() {
  //   setState(() {
  //     if (_currentPosition.latitude == 3423243) && {
  //       msg = 'We have learned FlutterRaised button example.';
  //     } else {
  //       msg = 'Flutter RaisedButton Example';
  //     }
  //   });
  // }
}
