import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter_appwrite/core/common/theme/app_color.dart';
import 'package:todo_flutter_appwrite/core/utils/size_utils.dart';
import 'package:todo_flutter_appwrite/features/todo/presentation/pages/add_todo.dart';

class TodoPage extends StatefulWidget {
  static final String routeName = 'todo';
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoState();
}

class _TodoState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Todos',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.person, color: AppColor.whiteColor, size: 30),
            ),
          ],
        ),
        body: Center(child: Text('Home Page')),

        floatingActionButton: Transform.scale(
          scale: 0.9,
          child: FloatingActionButton(
            onPressed: () => context.pushNamed(AddTodo.routeName),
            backgroundColor: AppColor.appColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(sr(50)),
            ),
            child: Icon(Icons.add, color: AppColor.whiteColor),
          ),
        ),
      ),
    );
  }
}
