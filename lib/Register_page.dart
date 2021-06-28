// import 'package:attendance_app/register_camera.dart';
import 'package:attendance_app/Register_camera.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _matController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            )),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Column(
                  children: [
                    Text(
                      "Take Picture",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Welcome, Register with your correct matric number",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      // makeInput(label: "MATRIC NO"),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "MATRIC NO",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: _matController,
                            // validator: (value) {
                            //   if (value == null) {
                            //     return 'Please Enter the your matric number';
                            //   }
                            //   return null;
                            // },
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.characters,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[400]!),
                              ),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!)),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    // padding: EdgeInsets.only(top: 1, left: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black))),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        ThemeData.dark();
                        if (_matController.text.isNotEmpty) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterCamera(
                                      matnumber:
                                          _matController.text.toUpperCase())));
                        } else {
                          final snackBar =
                              SnackBar(content: Text('INPUT MATRIC NUMBER'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      color: Colors.blue[900],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        "Take Picture",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Note: Ensure there is enough lighting while taking picture, press camera button five times to take five pictures!!!",
                          style: TextStyle(
                              color: Colors.redAccent[700],
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget makeInput({label, obsureText = false}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         label,
//         style: TextStyle(
//             fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
//       ),
//       SizedBox(
//         height: 5,
//       ),
//       TextFormField(
//         controller: _matController,
//         keyboardType: TextInputType.text,
//         textCapitalization: TextCapitalization.sentences,
//         obscureText: obsureText,
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey[400]!),
//           ),
//           border: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey[400]!)),
//         ),
//       ),
//       SizedBox(
//         height: 30,
//       )
//     ],
//   );
// }
