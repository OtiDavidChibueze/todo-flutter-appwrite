import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_flutter_appwrite/core/common/cubit/image_picker/image_picker_cubit.dart';
import 'package:todo_flutter_appwrite/core/common/theme/app_color.dart';
import 'package:todo_flutter_appwrite/core/common/widgets/custom_button_widget.dart';
import 'package:todo_flutter_appwrite/core/common/widgets/custom_textfield_widget.dart';
import 'package:todo_flutter_appwrite/core/constants/app_images_url.dart';
import 'package:todo_flutter_appwrite/core/constants/app_string.dart';
import 'package:todo_flutter_appwrite/core/utils/custom_snackbar.dart';
import 'package:todo_flutter_appwrite/core/utils/fullscreen_dialog_loader.dart';
import 'package:todo_flutter_appwrite/core/utils/size_utils.dart';
import 'package:todo_flutter_appwrite/core/utils/validation/validators.dart';
import 'package:todo_flutter_appwrite/features/auth/domain/entities/user_entity.dart';
import 'package:todo_flutter_appwrite/features/auth/presentation/bloc/auth_bloc.dart';

class Profile extends StatefulWidget {
  static const String routeName = 'profile';

  final UserEntity user;

  const Profile({super.key, required this.user});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _editProfileFormKey = GlobalKey<FormState>();
  late TextEditingController _firstname;
  late TextEditingController _lastname;
  late String _profileImage;

  @override
  void initState() {
    super.initState();
    _firstname = TextEditingController(text: widget.user.firstname);
    _lastname = TextEditingController(text: widget.user.lastname);
    _profileImage = widget.user.profileImage;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(AppString.profile), centerTitle: true),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(16)),
            child: Form(
              key: _editProfileFormKey,
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoadingState) {
                    FullscreenDialogLoader.show(context);
                  }

                  if (state is AuthSuccessState) {
                    FullscreenDialogLoader.cancel(context);
                    CustomSnackbar.info(context, AppString.profileUpdated);
                    context.pop();
                  }

                  if (state is AuthErrorState) {
                    FullscreenDialogLoader.cancel(context);
                    CustomSnackbar.error(context, state.errorMsg);
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(sr(100)),
                        child: BlocBuilder<ImagePickerCubit, ImagePickerState>(
                          builder: (context, state) {
                            if (state is ImagePickerLoadingState) {
                              return SizedBox(
                                height: h(200),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColor.appColor,
                                  ),
                                ),
                              );
                            }

                            if (state is ImagePickerSuccessState) {
                              return GestureDetector(
                                onTap: () =>
                                    context.read<ImagePickerCubit>().resetImg(),
                                child: Image.file(
                                  File(state.imagePath),
                                  fit: BoxFit.cover,
                                  width: w(200),
                                  height: h(200),
                                ),
                              );
                            }

                            if (state is ImagePickerErrorState) {
                              CustomSnackbar.error(context, state.errorMessage);
                              return Container(
                                color: AppColor.errorColor,
                                width: w(200),
                                height: h(200),
                                child: Center(
                                  child: CustomButtonWidget(
                                    btnText: AppString.retry,
                                    backgroundColor: AppColor.transparentColor,
                                    onPressed: () => context
                                        .read<ImagePickerCubit>()
                                        .resetImg(),
                                  ),
                                ),
                              );
                            }

                            return GestureDetector(
                              onTap: () =>
                                  context.read<ImagePickerCubit>().pickImage(),
                              child: Image.asset(
                                AppImageUrl.user,
                                fit: BoxFit.cover,
                                width: w(200),
                              ),
                            );
                          },
                        ),
                      ),

                      VSpace(30),

                      CustomTextfieldWidget(
                        hintText: AppString.firstname,
                        controller: _firstname,

                        validator: (value) => Validations.isEmpty(value),
                        keyboardType: TextInputType.name,
                      ),

                      VSpace(20),

                      CustomTextfieldWidget(
                        hintText: AppString.lastname,
                        controller: _lastname,
                        validator: (value) => Validations.isEmpty(value),
                        keyboardType: TextInputType.name,
                      ),

                      VSpace(30),

                      CustomButtonWidget(
                        btnText: AppString.update,
                        onPressed: () {
                          if (_editProfileFormKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              AuthEditProfileEvent(
                                firstname: _firstname.text.trim(),
                                lastname: _lastname.text.trim(),
                                profileImage: _profileImage,
                              ),
                            );
                          }
                        },
                      ),

                      VSpace(20),

                      CustomButtonWidget(
                        btnText: AppString.logout,
                        onPressed: () {},
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
