
import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_detail.g.dart';

class ImageDetailState {

  const ImageDetailState({
    required this.radiographyType,
    required this.file,
  });

  factory ImageDetailState.empty() =>
    ImageDetailState(
      radiographyType: '',
      file: File(''),
    );

  final String radiographyType;
  final File file;

  ImageDetailState copyWith({
    String? radiographyType,
    File? file,
  }) => ImageDetailState(
    radiographyType: radiographyType ?? this.radiographyType,
    file: file ?? this.file,
  );

}

@riverpod
class ImageDetail extends _$ImageDetail {

  @override
  ImageDetailState build() {
    return ImageDetailState.empty();
  }

  void setImage(File file) {
    state = state.copyWith(
      file: file,
    );
  }

  void setRadiography(String radiographyType) {
    state = state.copyWith(
      radiographyType: radiographyType,
    );
  }

}
