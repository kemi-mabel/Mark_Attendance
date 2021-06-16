import 'package:attendance_app/camerascreen/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:camera/camera.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late Position _currentPosition;
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
