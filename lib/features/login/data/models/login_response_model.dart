
import 'package:pneumonia_detection/features/login/data/models/models.dart';
import 'package:pneumonia_detection/features/login/domain/entities/entities.dart';

class LoginResponseModel {
  LoginResponseModel({
    required this.code,
    required this.mensaje,
    required this.data,
  });

  final int code;
  final String mensaje;
  final UserReponseModel data;

  factory LoginResponseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw const FormatException("JSON data is null");
    }
    return LoginResponseModel(
      code: json['code'] ?? 0,
      mensaje: json['mensaje'] ?? '',
      data: UserReponseModel.fromJson(json['data']),
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      apellido: data.apellido,
      createdAt: data.createdAt,
      documento: data.documento,
      email: data.email,
      id: data.id,
      nombre: data.nombre,
    );
  }

}