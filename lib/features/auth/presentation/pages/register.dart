import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter_appwrite/core/common/theme/app_color.dart';
import 'package:todo_flutter_appwrite/core/constants/app_images_url.dart';
import 'package:todo_flutter_appwrite/core/constants/app_string.dart';
import 'package:todo_flutter_appwrite/core/utils/custom_snackbar.dart';
import 'package:todo_flutter_appwrite/core/utils/fullscreen_dialog_loader.dart';
import 'package:todo_flutter_appwrite/core/utils/size_utils.dart';
import 'package:todo_flutter_appwrite/core/utils/validation/validators.dart';
import 'package:todo_flutter_appwrite/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:todo_flutter_appwrite/features/auth/presentation/pages/login.dart';
import 'package:todo_flutter_appwrite/features/auth/presentation/widgets/custom_button_widget.dart';
import 'package:todo_flutter_appwrite/features/auth/presentation/widgets/custom_textfield_widget.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = 'register';

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerKey = GlobalKey<FormState>();
  final TextEditingController _firstnameCtrl = TextEditingController();
  final TextEditingController _lastnameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void dispose() {
    super.dispose();

    _firstnameCtrl.dispose();
    _lastnameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
  }

  void clearInputs() {
    _firstnameCtrl.clear();
    _lastnameCtrl.clear();
    _emailCtrl.clear();
    _passwordCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            return FullscreenDialogLoader.show(context);
          }

          if (state is AuthErrorState) {
            FullscreenDialogLoader.cancel(context);
            CustomSnackbar.showError(context, state.errorMsg);
          }

          if (state is AuthSuccessState) {
            FullscreenDialogLoader.cancel(context);
            clearInputs();
            CustomSnackbar.showSuccess(context, AppString.registerSuccessMsg);
            context.goNamed(LoginPage.routeName);
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w(16),
                  vertical: h(16),
                ),
                child: Form(
                  key: _registerKey,
                  child: Column(
                    children: [
                      Image.asset(
                        AppImageUrl.logo,
                        width: w(100),
                        height: h(100),
                      ),

                      VSpace(20),

                      CustomTextfieldWidget(
                        hintText: AppString.fullname,
                        controller: _firstnameCtrl,
                        keyboardType: TextInputType.name,
                        validator: (value) => Validations.isEmpty(value),
                      ),

                      VSpace(20),

                      CustomTextfieldWidget(
                        hintText: AppString.lastname,
                        controller: _lastnameCtrl,
                        keyboardType: TextInputType.name,
                        validator: (value) => Validations.isEmpty(value),
                      ),

                      VSpace(20),

                      CustomTextfieldWidget(
                        hintText: AppString.email,
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => Validations.email(value),
                      ),

                      VSpace(20),

                      CustomTextfieldWidget(
                        hintText: AppString.password,
                        controller: _passwordCtrl,
                        obscureText: !isPasswordVisible,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) => Validations.password(value),
                        suffix: InkWell(
                          onTap: () {
                            isPasswordVisible = !isPasswordVisible;

                            setState(() {});
                          },
                          child: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColor.greyColor,
                          ),
                        ),
                      ),

                      VSpace(40),

                      CustomButtonWidget(
                        btnText: AppString.register,
                        onPressed: () {
                          if (_registerKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              AuthRegisterEvent(
                                firstname: _firstnameCtrl.text.trim(),
                                lastname: _lastnameCtrl.text.trim(),
                                email: _emailCtrl.text.trim(),
                                password: _passwordCtrl.text.trim(),
                              ),
                            );

                            clearInputs();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
