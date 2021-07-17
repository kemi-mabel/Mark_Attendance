import 'dart:io';
import 'dart:typed_data';
import 'package:attendance_app/utils/face_recognition.dart';
import 'package:flutter/material.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';

class PreviewImageScreen extends StatefulWidget {
  final String imagePath;
  final File imageFile;

  // final String description;
  // final double score;

  PreviewImageScreen({required this.imagePath, required this.imageFile});

  // ResponseElement({this.description, this.score});

  @override
  _PreviewImageScreenState createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  bool status = false;
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
                child: Image.file(File(widget.imagePath), fit: BoxFit.cover)),
            SizedBox(height: 10.0),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(60.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        status =
                            await faceRecognition.recogImage(widget.imageFile);
                        setState(() {
                          status;
                        });

                        // getBytesFromFile().then((bytes) {
                        //   Share.file('Share via:', basename(widget.imagePath),
                        //       bytes.buffer.asUint8List(), 'image/png');}
                        // );
                      },
                      child: Text('Send'),
                    ),
                    status ? Text("Recognized") : Text("Not Yet Recognized")
                  ],
                ),
              ),
            ),
            // Row(
            //   children: <Widget>[
            //     Text('Desciption:'),
            //     SizedBox(width: 10.0),
            //     Text(
            //       // '$description',
            //       style: TextStyle(
            //           color: Colors.orange, fontWeight: FontWeight.bold),
            //     )
            //   ],
            // ),
            // Row(
            //   children: <Widget>[
            //     Text('Score:'),
            //     SizedBox(width: 10.0),
            //     Text(
            //       '${score.toStringAsFixed(2)}%',
            //       style: TextStyle(
            //           color: Colors.orange, fontWeight: FontWeight.bold),
            //     )
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Future<ByteData> getBytesFromFile() async {
    Uint8List bytes = File(widget.imagePath).readAsBytesSync();
    return ByteData.view(bytes.buffer);
  }
}
