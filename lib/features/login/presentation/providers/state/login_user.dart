
import 'package:pneumonia_detection/features/login/domain/entities/entities.dart';
import 'package:pneumonia_detection/features/login/presentation/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_user.g.dart';

@riverpod
class UserLogin extends _$UserLogin {

  @override
  FutureOr<UserEntity> build() {
    return UserEntity.empty();
  }

  Future<void> login({
    required String documento,
    required String password,
  }) async {

    final repository = ref.read(userRepositoryProvider);

    final response = await repository.login(documento: documento, password: password);

    response.fold(
      (error) {
        state = AsyncError(
          error.message,
          error.stackTrace ?? StackTrace.current,
        );
      }, (data) {
        state = AsyncData(
          data ?? UserEntity.empty(),
        );
      }
    );

  }

}
