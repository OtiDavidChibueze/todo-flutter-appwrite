import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/todo_entity.dart';
import '../../../../core/common/theme/app_color.dart';
import '../../../../core/common/widgets/custom_textfield_widget.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../../../core/utils/fullscreen_dialog_loader.dart';
import '../../../../core/utils/size_utils.dart';
import '../../../../core/utils/validation/validators.dart';
import '../../../../core/common/widgets/custom_button_widget.dart';
import '../bloc/todo_bloc.dart';

class EditTodo extends StatefulWidget {
  static const String routeName = 'edit-todo';

  final TodoEntity editTodo;

  const EditTodo({super.key, required this.editTodo});

  @override
  State<EditTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<EditTodo> {
  final GlobalKey<FormState> _editTodoFormKey = GlobalKey<FormState>();
  late TextEditingController _title;
  late TextEditingController _description;
  late bool isCompleted;

  @override
  initState() {
    super.initState();
    _title = TextEditingController(text: widget.editTodo.title);
    _description = TextEditingController(text: widget.editTodo.description);
    isCompleted = widget.editTodo.isCompleted;
  }

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
          title: Text('Edit Todo'),
          centerTitle: true,
          backgroundColor: AppColor.appbarColor,
          actions: [
            IconButton(
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  dismissOnBackKeyPress: false,
                  dismissOnTouchOutside: false,
                  dialogType: DialogType.warning,
                  animType: AnimType.bottomSlide,
                  title: AppString.deleteTodo,
                  desc: AppString.deleteConfirm,
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    context.read<TodoBloc>().add(
                      DeleteTodoEvent(todoId: widget.editTodo.id),
                    );
                  },
                ).show();
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(16)),
            child: Form(
              key: _editTodoFormKey,
              child: BlocConsumer<TodoBloc, TodoState>(
                listener: (context, state) {
                  if (state is TodoLoadingState) {
                    FullscreenDialogLoader.show(context);
                  }

                  if (state is TodoSuccessState) {
                    FullscreenDialogLoader.cancel(context);
                    _clear();
                    CustomSnackbar.success(context, AppString.todoUpdate);
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

                      VSpace(20),

                      Checkbox(
                        activeColor: AppColor.appColor,
                        checkColor: AppColor.whiteColor,
                        value: isCompleted,
                        onChanged: (value) {
                          setState(() {
                            isCompleted = value!;
                          });
                        },
                      ),

                      VSpace(30),

                      CustomButtonWidget(
                        btnText: AppString.update,
                        onPressed: () {
                          if (_editTodoFormKey.currentState!.validate()) {
                            context.read<TodoBloc>().add(
                              EditTodoEvent(
                                todoId: widget.editTodo.id,
                                title: _title.text.trim(),
                                description: _description.text.trim(),
                                isCompleted: isCompleted,
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
