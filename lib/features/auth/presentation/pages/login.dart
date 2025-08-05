import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter_appwrite/core/common/theme/app_color.dart';
import 'package:todo_flutter_appwrite/core/constants/app_images_url.dart';
import 'package:todo_flutter_appwrite/core/constants/app_string.dart';
import 'package:todo_flutter_appwrite/core/utils/size_utils.dart';
import 'package:todo_flutter_appwrite/core/utils/validation/validators.dart';
import 'package:todo_flutter_appwrite/features/auth/presentation/pages/register.dart';
import 'package:todo_flutter_appwrite/features/auth/presentation/widgets/custom_button_widget.dart';
import 'package:todo_flutter_appwrite/features/auth/presentation/widgets/custom_textfield_widget.dart';

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
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
  }

  void handleLogin() {
    if (_loginKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(16)),
            child: Form(
              key: _loginKey,
              child: Column(
                children: [
                  Image.asset(AppImageUrl.logo, width: w(100), height: h(100)),

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
                    btnText: AppString.login,
                    onPressed: () => handleLogin(),
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
      ),
    );
  }
}
