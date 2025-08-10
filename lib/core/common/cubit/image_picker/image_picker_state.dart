part of 'image_picker_cubit.dart';

sealed class ImagePickerState {}

final class ImagePickerInitialState extends ImagePickerState {}

final class ImagePickerLoadingState extends ImagePickerState {}

final class ImagePickerSuccessState extends ImagePickerState {
  final String imagePath;

  ImagePickerSuccessState({required this.imagePath});
}

final class ImagePickerErrorState extends ImagePickerState {
  final String errorMessage;

  ImagePickerErrorState({required this.errorMessage});
}
