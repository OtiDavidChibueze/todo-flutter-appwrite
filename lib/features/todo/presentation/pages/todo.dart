import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'edit_todo.dart';
import '../../../../core/common/theme/app_color.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/utils/size_utils.dart';
import '../../domain/entities/todo_entity.dart';
import '../bloc/todo_bloc.dart';
import 'add_todo.dart';

class TodoPage extends StatefulWidget {
  static final String routeName = 'todo';
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoState();
}

class _TodoState extends State<TodoPage> {
  @override
  void initState() {
    super.initState();

    context.read<TodoBloc>().add(GetTodosEvent());
  }

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
              onPressed: () {}, // todo navigate to profile page
              icon: Icon(Icons.person),
            ),
          ],
        ),
        body: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoLoadingState) {
              return Center(
                child: CircularProgressIndicator(color: AppColor.appColor),
              );
            }

            if (state is TodoErrorState) {
              return Center(child: Text(state.errorMessage));
            }

            if (state is TodoSuccessState) {
              return state.todos.isNotEmpty
                  ? _buildTodoList(context: context, todos: state.todos)
                  : Center(child: Text(AppString.todoEmpty));
            }

            return SizedBox();
          },
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () => context.pushNamed(AddTodo.routeName),
          backgroundColor: AppColor.appColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(sr(50)),
          ),
          child: Icon(Icons.add, color: AppColor.whiteColor),
        ),
      ),
    );
  }

  Widget _buildTodoList({
    required BuildContext context,
    required List<TodoEntity> todos,
  }) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];

        return ListTile(
          onTap: () => context.pushNamed(EditTodo.routeName, extra: todo),
          leading: CircleAvatar(
            radius: sr(10),
            backgroundColor: todo.isCompleted
                ? AppColor.snackbarGreen
                : AppColor.snackbarRed,
          ),
          title: Text(todo.title),
          subtitle: Text(todo.description),
        );
      },
    );
  }
}
