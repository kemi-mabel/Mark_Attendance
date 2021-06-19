import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class PageImageScreen extends StatefulWidget {
  final List<String> imagePath;
  final String matricNumber;

  PageImageScreen({required this.imagePath, required this.matricNumber});

  @override
  _PageImageScreenState createState() =>
      _PageImageScreenState(this.matricNumber);
}

class _PageImageScreenState extends State<PageImageScreen> {
  // bool uploading = false;
  // CollectionReference imgRef = null as CollectionReference;
  // firebase_storage.Reference ref = null as firebase_storage.Reference;

  // List<File> _image = [];
  // double val = 0;

  bool loading = false;
  double progress = 0;

<<<<<<< HEAD
  String _matricNumber;
  _PageImageScreenState(this._matricNumber);
=======
  static const _url = "https://esiwesregistration.000webhostapp.com/esiwesreg/";
>>>>>>> 0b1f9c138d8e83ab2064318634a54b09f2f7b010

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
                  Image.file(File(widget.imagePath[1]), fit: BoxFit.cover),
                  Image.file(File(widget.imagePath[2]), fit: BoxFit.cover),
                  Image.file(File(widget.imagePath[3]), fit: BoxFit.cover),
                  Image.file(File(widget.imagePath[4]), fit: BoxFit.cover)
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Flexible(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.all(60.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // setState(() {
                        //   uploading = true;
                        // });
                        // uploadFile()
                        //     .whenComplete(() => Navigator.of(context).pop());
                        //   getBytesFromFile().then((bytes) {
                        // Share.file('Share via:', basename(widget.imagePath),
                        //     bytes.buffer.asUint8List(), 'image/png');
                        // });
                        // downloadFile();
                        _uploadcapturedImages(widget.imagePath);
                      },
                      child: Text(
                        'upload',
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

<<<<<<< HEAD
  _uploadcapturedImages(List<String> path) async {
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
=======
  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  Future<bool> saveImage(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          String newPath = "";
          print(directory);
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/ATTApp";
          directory = Directory(newPath);
        } else {
          return false;
        }
>>>>>>> 0b1f9c138d8e83ab2064318634a54b09f2f7b010
      } else {
        print('Error from image repo ${snapshot.state.toString()}');
        throw ('This file is not an image');
      }
    }
  }

  // Future<bool> saveImage(String url, String fileName) async {
  //   Directory directory;
  //   try {
  //     if (Platform.isAndroid) {
  //       if (await _requestPermission(Permission.storage)) {
  //         directory = await getExternalStorageDirectory();
  //         String newPath = "";
  //         print(directory);
  //         List<String> paths = directory.path.split("/");
  //         for (int x = 1; x < paths.length; x++) {
  //           String folder = paths[x];
  //           if (folder != "Android") {
  //             newPath += "/" + folder;
  //           } else {
  //             break;
  //           }
  //         }
  //         newPath = newPath + "/ATTApp";
  //         directory = Directory(newPath);
  //       } else {
  //         return false;
  //       }
  //     } else {
  //       if (await _requestPermission(Permission.photos)) {
  //         directory = await getTemporaryDirectory();
  //       } else {
  //         return false;
  //       }
  //     }

  //     if (!await directory.exists()) {
  //       await directory.create(recursive: true);
  //     }
  //     if (await directory.exists()) {
  //       File saveFile = File(directory.path + "/$fileName");
  //       await Dio().download(url, saveFile.path,
  //           onReceiveProgress: (value1, value2) {
  //         setState(() {
  //           progress = value1 / value2;
  //         });
  //       });
  //       if (Platform.isIOS) {
  //         await ImageGallerySaver.saveFile(saveFile.path,
  //             isReturnPathOfIOS: true);
  //       }
  //       return true;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   return false;
  // }

  // downloadFile() async {
  //   setState(() {
  //     loading = true;
  //     progress = 0;
  //   });
  //   // saveVideo will download and save file to Device and will return a boolean
  //   // for if the file is successfully or not
  //   bool downloaded = await saveImage(widget.imagePath[0], "one.jpg");
  //   saveImage(widget.imagePath[1], "two.jpg");
  //   saveImage(widget.imagePath[2], "three.jpg");
  //   saveImage(widget.imagePath[3], "four.jpg");
  //   saveImage(widget.imagePath[4], "five.jpg");

  //   if (downloaded) {
  //     print("File Downloaded");
  //   } else {
  //     print("Problem Downloading File");
  //   }

  //   setState(() {
  //     loading = false;
  //   });
  // }

  // Future<bool> _requestPermission(Permission permission) async {
  //   if (await permission.isGranted) {
  //     return true;
  //   } else {
  //     var result = await permission.request();
  //     if (result == PermissionStatus.granted) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  // Future<ByteData> getBytesFromFile() async {
  //   Uint8List bytes = File(widget.imagePath).readAsBytesSync() as Uint8List;
  //   return ByteData.view(bytes.buffer);
  // }

  //   Future uploadFile() async {
  //     int i = 1;

  //     for (var img in _image) {
  //       setState(() {
  //         val = i / _image.length;
  //       });
  //       ref = firebase_storage.FirebaseStorage.instance
  //           .ref()
  //           .child('images/${Path.basename(img.path)}');
  //       await ref.putFile(img).whenComplete(() async {
  //         await ref.getDownloadURL().then((value) {
  //           imgRef.add({'url': value});
  //           i++;
  //         });
  //       });
  //     }
  //   }

  //   @override
  //   void initState() {
  //     super.initState();
  //     imgRef = FirebaseFirestore.instance.collection('imageURLs');
  //   }
}
