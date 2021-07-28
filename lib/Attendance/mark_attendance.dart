import 'dart:convert' as convert;
import 'dart:io';
import 'package:attendance_app/utils/form.dart';
import 'package:csv/csv.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

/// FormController is a class which does work of saving FeedbackForm in Google Sheets using
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class FormController {
  // Google App Script Web URL.
  static const String URL =
      "https://script.google.com/macros/s/AKfycbz3lXbp33xiQtPY2Xev7qgGzK7MrQL0C-z19lkk8yQDwepXOvItnIwNGuMBg_8Jz3TKTQ/exec";

  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
  void submitForm(
      FeedbackForm feedbackForm, void Function(String) callback) async {
    try {
      await http.post(URL, body: feedbackForm.toJson()).then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(url).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<FeedbackForm>> getFeedbackList() async {
    return await http.get(URL).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      return jsonFeedback.map((json) => FeedbackForm.fromJson(json)).toList();
    });
  }

  late String filePath;

  Future<String> get _localPath async {
    final directory = await getApplicationSupportDirectory();
    return directory.absolute.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    filePath = '$path/attendance.csv';
    return File('$path/attendance.csv').create();
  }

  getCsv(List<FeedbackForm> feedbackList) async {
    List<List<String>> data = [
      ["Matric No", "Attendance"],
    ];
    feedbackList.forEach((element) {
      data.add([element.matricno, element.attendance]);
    });

    File f = await _localFile;

    String csv = const ListToCsvConverter().convert(data);
    f.writeAsString(csv);
  }

  sendMailAndAttachment() async {
    final Email email = Email(
      body: 'Good Day Sir, the  attendance it!',
      subject: 'Attendance Entry for ${DateTime.now().toString()}',
      recipients: ['oluwakemi.mabell@gmail.com'],
      isHTML: true,
      attachmentPath: filePath,
    );

    await FlutterEmailSender.send(email);
  }
}
