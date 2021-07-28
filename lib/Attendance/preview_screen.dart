import 'dart:io';
import 'dart:typed_data';
import 'package:attendance_app/utils/face_recognition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:attendance_app/utils/form.dart';
import 'mark_attendance.dart';

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
  FaceRecognition faceRecognition = FaceRecognition();

  String studentId = "Your Attendance is yet to be taken";

  late List<FeedbackForm> feedbackItems;
// List<FeedbackForm> feedbackItems = List<FeedbackForm>();

  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    // If the form is valid, proceed.
    FeedbackForm feedbackForm = FeedbackForm(studentId, '1');

    FormController formController = FormController();

    _showSnackbar("Submitting Feedback");

    // Submit 'feedbackForm' and save it in Google Sheets.
    formController.submitForm(feedbackForm, (String response) {
      print("Response: $response");
      if (response == FormController.STATUS_SUCCESS) {
        // Feedback is saved succesfully in Google Sheets.
        _showSnackbar("Attendance Uploaded");
      } else {
        // Error Occurred while saving data in Google Sheets.
        _showSnackbar("Error Occurred!");
      }
    });
  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();

    FormController().getFeedbackList().then((feedbackItems) {
      setState(() {
        this.feedbackItems = feedbackItems;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Preview'), backgroundColor: Colors.black),
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
                        Map<String, dynamic> info =
                            await faceRecognition.recogImage(widget.imageFile);
                        setState(() {
                          status = info['status'];
                          studentId = info['subjectId'];
                          _submitForm();
                        });
                      },
                      child: Text('Send'),
                    ),
                    status ? Text("Recognized") : Text("Not Yet Recognized"),
                    status
                        ? Text(
                            'Congratulations $studentId your attendance has been captured')
                        : Text('$studentId'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
