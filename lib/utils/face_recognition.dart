import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class FaceRecognition {
  Dio dio = Dio();

  Response response = null as Response;

  String rapidAPIKey = "yoo";
  String kairosURL = "api.kairos.com";
  String appID = "yoo";

  FaceRecognition() {
    dio.options.headers = {
      "app_id": appID,
      "x-rapidapi-host": kairosURL,
      "x-rapidapi-key": rapidAPIKey,
      "content-type": "application/json",
    };
  }

  //Enroll Image in the database
  Future<Response> enrollImage(File file, String subjectId) async {
    // TODO: Add the gallery name according to the name of the store

    dio.options.headers = {
      "app_id": appID,
      "x-rapidapi-host": kairosURL,
      "x-rapidapi-key": rapidAPIKey,
      "content-type": "application/json",
    };

    try {
      String base64Image = base64Encode(file.readAsBytesSync());

      response = await dio.post(
        "http://api.kairos.com/enroll",
        data: {
          "image": base64Image,
          "gallery_name": "Oluwakemi",
          "subject_id": subjectId,
        },
      );

      print("INSISE TRY: ");
      print("RESPOSNSE: " + response.toString());
      print("YO; ${response.data.toString()}");
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

    return response;
  }

  /// Returns [true] if confidence > 65% and imageId = name
  Future<bool> recogImage(File file) async {
    dio.options.headers = {
      "app_id": appID,
      "x-rapidapi-host": kairosURL,
      "x-rapidapi-key": rapidAPIKey,
      "content-type": "application/json",
    };

    try {
      String base64Image = base64Encode(file.readAsBytesSync());
      // TODO: Receive the store name also
      response = await dio.post(
        "http://api.kairos.com/recognize",
        data: {
          "image": file,
          "gallery_name": "Oluwakemi",
        },
      );
      print("RESPOSNSE: " + response.toString());
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
    if (parseResponse['images'] == null) return false;

    String _confi =
        parseResponse['images'][0]['candidates'][0]['confidence'].toString();
    double confidence = double.parse(_confi) * 100.0;

    String subjectId =
        parseResponse['images'][0]['candidates'][0]['subject_id'];
    print(subjectId);

    return (confidence > 65);
  }
}
