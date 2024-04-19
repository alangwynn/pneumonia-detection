
import 'package:fpdart/fpdart.dart';
import 'package:pneumonia_detection/config/client/api_http_client.dart';
import 'package:pneumonia_detection/config/client/client_config.dart';
import 'package:pneumonia_detection/features/login/data/models/models.dart';
import 'package:pneumonia_detection/features/login/domain/datasources/datasources.dart';
import 'package:pneumonia_detection/features/login/domain/entities/user_entity.dart';

class UserRemoteDatasource extends UserDatasource {

  UserRemoteDatasource({
    required ApiHttpClient  apiHttpClient,
  }) : _client = apiHttpClient;

  final ApiHttpClient _client;

  static const _basePath = '/user';

  @override
  Future<Result<UserEntity?>> login({required String documento, required String password}) async {
    
    final response = await _client.post(
      path: '$_basePath/login',
      deserializeResponseFunction: LoginResponseModel.fromJson,
      payload: {
        "documento": documento,
        "password": password,
      }
    );

    final data = response.flatMap((a) => right(a?.toEntity()));

    return data;
  }

  @override
  Future<Result<SignUpResponseModel?>> register({
    required String email,
    required String nombre,
    required String apellido,
    required String documento,
    required String password,
  }) async {
    
    final response = await _client.post(
      path: '$_basePath/crear',
      deserializeResponseFunction: SignUpResponseModel.fromJson,
      payload: {
        'email': email,
        'nombre': nombre,
        'apellido': apellido,
        'documento': documento,
        'password': password,
      }
    );

    return response;
  }
  
}
