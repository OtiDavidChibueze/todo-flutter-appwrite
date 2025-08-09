import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter_appwrite/core/common/theme/app_color.dart';
import 'package:todo_flutter_appwrite/core/common/widgets/custom_textfield_widget.dart';
import 'package:todo_flutter_appwrite/core/constants/app_string.dart';
import 'package:todo_flutter_appwrite/core/utils/custom_snackbar.dart';
import 'package:todo_flutter_appwrite/core/utils/fullscreen_dialog_loader.dart';
import 'package:todo_flutter_appwrite/core/utils/size_utils.dart';
import 'package:todo_flutter_appwrite/core/utils/validation/validators.dart';
import 'package:todo_flutter_appwrite/core/common/widgets/custom_button_widget.dart';
import 'package:todo_flutter_appwrite/features/todo/presentation/bloc/todo_bloc.dart';

class AddTodo extends StatefulWidget {
  static const String routeName = 'add-todo';

  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final GlobalKey<FormState> _addTodoFormKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _title.dispose();
    _description.dispose();
  }

  void _clear() {
    _title.clear();
    _description.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Todo'),
          centerTitle: true,
          backgroundColor: AppColor.appbarColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(16)),
            child: Form(
              key: _addTodoFormKey,
              child: BlocConsumer<TodoBloc, TodoState>(
                listener: (context, state) {
                  if (state is TodoLoadingState) {
                    FullscreenDialogLoader.show(context);
                  }

                  if (state is TodoSuccessState) {
                    FullscreenDialogLoader.cancel(context);
                    _clear();
                    CustomSnackbar.info(context, AppString.todoAdded);
                    context.pop();
                  }

                  if (state is TodoErrorState) {
                    FullscreenDialogLoader.cancel(context);
                    CustomSnackbar.info(context, state.errorMessage);
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      CustomTextfieldWidget(
                        hintText: AppString.title,
                        controller: _title,
                        validator: (value) => Validations.isEmpty(value),
                        keyboardType: TextInputType.text,
                        maxLines: null,
                      ),

                      VSpace(20),

                      CustomTextfieldWidget(
                        hintText: AppString.description,
                        controller: _description,
                        validator: (value) => Validations.isEmpty(value),
                        keyboardType: TextInputType.text,
                        maxLines: null,
                      ),

                      VSpace(30),

                      CustomButtonWidget(
                        btnText: AppString.add,
                        onPressed: () {
                          if (_addTodoFormKey.currentState!.validate()) {
                            context.read<TodoBloc>().add(
                              AddTodoEvent(
                                title: _title.text.trim(),
                                description: _description.text.trim(),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
