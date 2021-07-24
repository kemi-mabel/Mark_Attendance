import 'dart:io';
import 'package:attendance_app/utils/face_recognition.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'dart:async';
// import 'package:dio/dio.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

class PageImageScreen extends StatefulWidget {
  final List<String> imagePath;
  final String matricNumber;
  final File imageFile;

  PageImageScreen(
      {required this.imagePath,
      required this.matricNumber,
      required this.imageFile});

  @override
  _PageImageScreenState createState() =>
      _PageImageScreenState(this.matricNumber);
}

class _PageImageScreenState extends State<PageImageScreen> {
  // bool uploading = false;
  String _matricNumber;
  _PageImageScreenState(this._matricNumber);
  bool loading = false;
  double progress = 0;
  FaceRecognition faceRecognition = new FaceRecognition();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Preview'), backgroundColor: Colors.purple),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: PageView(
                children: [
                  Image.file(File(widget.imagePath[0]), fit: BoxFit.cover),
                  // Image.file(File(widget.imagePath[1]), fit: BoxFit.cover),
                  // Image.file(File(widget.imagePath[2]), fit: BoxFit.cover),
                  // Image.file(File(widget.imagePath[3]), fit: BoxFit.cover),
                  // Image.file(File(widget.imagePath[4]), fit: BoxFit.cover)
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Flexible(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.all(60.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        await faceRecognition
                            .enrollImage(widget.imageFile, _matricNumber)
                            .then((value) {
                          print("Uploaded");
                        });
                        final snackBar =
                            SnackBar(content: Text('IMAGE UPLOADED'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        // await _uploadcapturedImage(widget.imagePath);
                        Navigator.pop(context);
                        // setState(() {
                        //   uploading = true;
                        // });
                        //save the image
                      },
                      child: Text(
                        'Upload',
                        style: TextStyle(color: Colors.white),
                      ),
                      // uploading
                      //     ? Center(
                      //         child: Column(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           Container(
                      //             child: Text(
                      //               'uploading...',
                      //               style: TextStyle(fontSize: 20),
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             height: 10,
                      //           ),
                      //           CircularProgressIndicator(
                      //             value: val,
                      //             valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      //           )
                      //         ],
                      //       ))
                      // Container(),
                    )))
          ],
        ),
      ),
    );
  }

  _uploadcapturedImage(List<String> path) async {
    print(_matricNumber);
    for (int i = 0; i < path.length; i++) {
      var file = File(path[i]);
      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref()
          .child("$_matricNumber/${i + 1}")
          .putFile(file);

      if (snapshot.state == TaskState.success) {
        final snackBar =
            SnackBar(content: Text('You Have Successfully Registered'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        print('Error from image repo ${snapshot.state.toString()}');
        throw ('This file is not an image');
      }
    }
  }
}
