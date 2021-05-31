import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'dart:async';
import 'home_page.dart';

class Todo {
  final String title;

  Todo(this.title);
}

void main() {
  runApp(MaterialApp(
    title: 'Covenant University',
    theme: ThemeData(
      // primarySwatch: Colors.deepPurple[600],
      brightness: Brightness.dark,
      primaryColor: Colors.deepPurple[600],
      accentColor: Colors.cyan[600],
    ),
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
      body: Center(
        child: ElevatedButton(
          child: Text('Attendance'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SecondRoute(
                        todos: List.generate(
                          20,
                          (i) => Todo(
                            'EIE 52$i',
                          ),
                        ),
                      )),
            );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  final List<Todo> todos;

  SecondRoute({Key? key, required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
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
                  builder: (context) => HomePage(),
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
