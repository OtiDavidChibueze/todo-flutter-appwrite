part of 'image_picker_cubit.dart';

sealed class ImagePickerState {}

final class ImagePickerInitialState extends ImagePickerState {}

final class ImagePickerLoadingState extends ImagePickerState {}

final class ImagePickerSuccessState extends ImagePickerState {
  final XFile imageFile;

  ImagePickerSuccessState({required this.imageFile});
}

final class ImagePickerErrorState extends ImagePickerState {
  final String errorMessage;

  ImagePickerErrorState({required this.errorMessage});
}
