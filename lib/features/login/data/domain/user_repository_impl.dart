
import 'package:pneumonia_detection/config/client/client_config.dart';
import 'package:pneumonia_detection/features/login/data/models/models.dart';
import 'package:pneumonia_detection/features/login/domain/datasources/datasources.dart';
import 'package:pneumonia_detection/features/login/domain/entities/user_entity.dart';
import 'package:pneumonia_detection/features/login/domain/repositories/repositories.dart';

class UserRepositoryImpl extends UserRepository {

  UserRepositoryImpl({
    required this.datasource,
  });

  final UserDatasource datasource;

  @override
  Future<Result<UserEntity?>> login({required String documento, required String password}) {
    return datasource.login(documento: documento, password: password);
  }

  @override
  Future<Result<SignUpResponseModel?>> register({required String email, required String nombre, required String apellido, required String documento, required String password}) {
    return datasource.register(email: email, nombre: nombre, apellido: apellido, documento: documento, password: password);
  }
  
}
