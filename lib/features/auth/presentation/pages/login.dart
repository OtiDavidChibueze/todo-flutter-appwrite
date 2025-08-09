import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/custom_snackbar.dart';
import '../../../../core/utils/fullscreen_dialog_loader.dart';
import '../bloc/auth_bloc.dart';
import '../../../../core/common/theme/app_color.dart';
import '../../../../core/constants/app_images_url.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/utils/size_utils.dart';
import '../../../../core/utils/validation/validators.dart';
import 'register.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/custom_textfield_widget.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = 'login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginKey = GlobalKey<FormState>();

  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void dispose() {
    super.dispose();

    _emailCtrl.dispose();
    _passwordCtrl.dispose();
  }

  void clearInputs() {
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
            clearInputs();
            CustomSnackbar.error(context, state.errorMsg);
          }

          if (state is AuthSuccessState) {
            FullscreenDialogLoader.cancel(context);
            clearInputs();
            CustomSnackbar.success(context, AppString.loginSuccessMsg);
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
                  key: _loginKey,
                  child: Column(
                    children: [
                      Image.asset(
                        AppImageUrl.logo,
                        width: w(100),
                        height: h(100),
                      ),

                      VSpace(20),

                      CustomTextfieldWidget(
                        hintText: AppString.email,
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => Validations.isEmpty(value),
                      ),

                      VSpace(20),

                      CustomTextfieldWidget(
                        hintText: AppString.password,
                        controller: _passwordCtrl,
                        obscureText: !isPasswordVisible,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) => Validations.isEmpty(value),
                        suffix: InkWell(
                          onTap: () {
                            isPasswordVisible = !isPasswordVisible;

                            setState(() {});
                          },
                          child: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: isPasswordVisible
                                ? AppColor.whiteColor
                                : AppColor.greyColor,
                          ),
                        ),
                      ),

                      VSpace(40),

                      CustomButtonWidget(
                        btnText: AppString.login,
                        onPressed: () {
                          if (_loginKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              AuthLoginEvent(
                                email: _emailCtrl.text,
                                password: _passwordCtrl.text,
                              ),
                            );
                          }
                        },
                      ),

                      VSpace(20),

                      GestureDetector(
                        onTap: () => context.pushNamed(RegisterPage.routeName),
                        child: RichText(
                          text: TextSpan(
                            text: AppString.newUser,
                            children: [
                              TextSpan(
                                text: AppString.register,
                                style: TextStyle(
                                  color: AppColor.appColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: sp(14),
                                ),
                              ),
                            ],
                          ),
                        ),
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
