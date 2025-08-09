import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  static final String routeName = 'todo';
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoState();
}

class _TodoState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Home Page')));
  }
}
