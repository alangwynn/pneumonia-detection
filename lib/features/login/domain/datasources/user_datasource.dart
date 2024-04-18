import 'package:pneumonia_detection/config/client/client_config.dart';
import 'package:pneumonia_detection/features/login/domain/entities/entities.dart';

abstract class UserDatasource {

  Future<Result<UserEntity?>> login({
    required String documento,
    required String password,
  });

  Future<Result<UserEntity>> register({
    required String email,
    required String nombre,
    required String apellido,
    required String documento,
    required String password,
  });

}