
import 'package:pneumonia_detection/features/login/data/models/models.dart';
import 'package:pneumonia_detection/features/login/presentation/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_up_user.g.dart';

@riverpod
class SignUpUser extends _$SignUpUser {

  @override
  FutureOr<SignUpResponseModel> build() {
    return SignUpResponseModel.empty();
  }

  Future<void> signUpUser({
    required String email,
    required String nombre,
    required String apellido,
    required String documento,
    required String password,
  }) async {

    final repository = ref.read(userRepositoryProvider);

    final response = await repository.register(email: email, nombre: nombre, apellido: apellido, documento: documento, password: password);

    response.fold(
      (error) {
        state = AsyncError(
          error.message,
          error.stackTrace ?? StackTrace.current,
        );
      }, (data) {
        state = AsyncData(
          data ?? SignUpResponseModel.empty(),
        );
      }
    );

  }

}
