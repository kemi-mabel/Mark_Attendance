import 'package:attendance_app/Register_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'dart:async';
import 'Location_page.dart';
// import 'register_camera.dart';

class Todo {
  final String title;

  Todo(this.title);
}

void main() {
  runApp(MaterialApp(
    title: 'Covenant University',
    theme: ThemeData(
        // primarySwatch: Colors.deepPurple[600],
        brightness: Brightness.light,
        primaryColor: Colors.deepPurple[600],
        accentColor: Colors.cyan[600],
        backgroundColor: Colors.white),
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome!'),
          backgroundColor: Colors.deepPurple[400],
        ),
        body: SafeArea(
            child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Hello There!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Thanks for coming to class, Fisrt time? please register.",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 15),
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/Illustration.png'))),
                    ),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        ThemeData.dark();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      color: Colors.deepPurple[400],
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(40)),
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white70),
                      ),
                    ),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondRoute(
                                    todos: List.generate(
                                      9,
                                      (i) => Todo(
                                        'EIE 52$i',
                                      ),
                                    ),
                                  )),
                        );
                      },
                      color: Colors.lightBlue[900],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      child: Text(
                        "Attendance",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ))));
  }
}

class SecondRoute extends StatelessWidget {
  final List<Todo> todos;

  SecondRoute({Key? key, required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            // When a user taps the ListTile, navigate to the DetailScreen.
            // Notice that you're not only creating a DetailScreen, you're
            // also passing the current todo through to it.
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocationPage(),
                  // Pass the arguments as part of the RouteSettings. The
                  // DetailScreen reads the arguments from these settings.
                  settings: RouteSettings(
                    arguments: todos[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
