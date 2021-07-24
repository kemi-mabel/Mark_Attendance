import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class FaceRecognition {
  Dio dio = Dio();

  Response response = null as Response;

  String kairoAPIKey = "133f3f5b2bae4aef59f527b7c821a1c8";
  String kairoId = "adc74e5d";
  String kairosURL = "api.kairos.com";

  FaceRecognition() {
    dio.options.headers = {
      "content-type": "application/json",
      "app_id": kairoId,
      "app_key": kairoAPIKey,
    };
  }

  //Enroll Image in the database
  Future<Response> enrollImage(File file, String subjectId) async {
    // TODO: Add the gallery name according to the name of the store

    dio.options.headers = {
      "content-type": "application/json",
      "app_id": kairoId,
      "app_key": kairoAPIKey,
    };

    try {
      String base64Image = base64Encode(file.readAsBytesSync());

      response = await dio.post(
        "https://api.kairos.com/enroll",
        data: {
          "image": base64Image,
          "subject_id": "$subjectId",
          "gallery_name": "Oluwakemi",
        },
      );

      Map<String, dynamic> parseResponse = jsonDecode(response.toString());
      String _status = parseResponse['images'] == null
          ? parseResponse['Errors'][0]['Message']
          : parseResponse['images'][0]['transaction']['status'].toString();

      // // print("RESPOSNSE: " + response.toString());
      print(_status);
      print("YO; ${response.data.toString()}");
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        print(e.response.statusMessage);
        print("Some errors due to API providers");
      } else {
        print(e.request);
        print(e.message);
        print("API Backend Confirmed");
      }
    }

    return response;
  }

  /// Returns [true] if confidence > 65% and imageId = name
  Future<Map<String, dynamic>> recogImage(File file) async {
    Map<String, dynamic> screenInfo = {};
    dio.options.headers = {
      "content-type": "application/json",
      "app_id": kairoId,
      "app_key": kairoAPIKey,
    };

    try {
      String base64Image = base64Encode(file.readAsBytesSync());
      // TODO: Receive the store name also
      response = await dio.post(
        "https://api.kairos.com/recognize",
        data: {
          "image": base64Image,
          "gallery_name": "Oluwakemi",
        },
      );
      // print("RESPOSNSE: " + response.toString());

    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
    }

    Map<String, dynamic> parseResponse = jsonDecode(response.toString());
    if ((parseResponse['images'] == null) &&
        (parseResponse['images'][0]['candidates'] == null))
      return screenInfo = {'status': false, 'subjectId': 'Place try again'};

    String _confi =
        parseResponse['images'][0]['candidates'][0]['confidence'].toString();
    double confidence = double.parse(_confi) * 100.0;

    String subjectId =
        parseResponse['images'][0]['candidates'][0]['subject_id'];

    screenInfo = {'status': (confidence > 65), 'subjectId': subjectId};
    print(subjectId);
    print(_confi);

    return (screenInfo);
  }
}
