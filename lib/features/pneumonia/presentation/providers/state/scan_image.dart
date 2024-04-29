import 'dart:io';

import 'package:pneumonia_detection/features/login/presentation/providers/state/login_user.dart';
import 'package:pneumonia_detection/features/pneumonia/domain/entities/entities.dart';
import 'package:pneumonia_detection/features/pneumonia/presentation/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scan_image.g.dart';

@riverpod
class ScanPneumoniaImage extends _$ScanPneumoniaImage {
  @override
  FutureOr<PneumoniaEntity> build() {
    return PneumoniaEntity.empty();
  }

  Future<void> scanImagen({
    required String documento,
    required File image,
  }) async {
    state = const AsyncLoading();

    final repository = ref.read(pneumoniaDetectionRepositoryProvider);

    final response = await repository.scanRadiography(
      documento: documento,
      image: image,
      userId: ref.read(userLoginProvider.notifier).state.value!.id.toString(),
    );

    response.fold((error) {
      state = AsyncError(
        error.message,
        error.stackTrace ?? StackTrace.current,
      );
    }, (data) {
      state = AsyncData(
        data ?? PneumoniaEntity.empty(),
      );
    });
  }
}
