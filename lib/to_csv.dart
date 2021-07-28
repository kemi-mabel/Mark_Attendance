import 'package:flutter/material.dart';

/// This is the stateful widget that the main application instantiates.
class SendMail extends StatefulWidget {
  const SendMail({Key? key}) : super(key: key);

  @override
  State<SendMail> createState() => _SendMailState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _SendMailState extends State<SendMail> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 30),
          ElevatedButton(
            style: style,
            onPressed: () {
              // call the send mail and attachement function
            },
            child: const Text('GET ATTENDANCE'),
          ),
        ],
      ),
    );
  }
}
