import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_flutter_appwrite/core/constants/app_string.dart';

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  final ImagePicker _imagePicker;

  ImagePickerCubit({required ImagePicker imagePicker})
    : _imagePicker = imagePicker,
      super(ImagePickerInitialState());

  Future<void> pickImage() async {
    try {
      emit(ImagePickerLoadingState());

      final pickImage = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickImage == null || pickImage.path.isEmpty || pickImage.path == '') {
        return emit(ImagePickerErrorState(errorMessage: AppString.imageError));
      }

      return emit(ImagePickerSuccessState(imagePath: pickImage.path));
    } catch (e) {
      emit(ImagePickerLoadingState());
      return emit(ImagePickerErrorState(errorMessage: e.toString()));
    }
  }

  void resetImg() {
    Future.delayed(Duration(seconds: 1), () {
      return emit(ImagePickerInitialState());
    });
  }
}
