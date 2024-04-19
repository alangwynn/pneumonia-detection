
class SignUpResponseModel {

  SignUpResponseModel({
    required this.code,
    required this.mensaje,
  });

  final int code;
  final String mensaje;

  factory SignUpResponseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw const FormatException("JSON data is null");
    }
    return SignUpResponseModel(
      code: json['code'] ?? 0,
      mensaje: json['mensaje'] ?? '',
    );
  }

  factory SignUpResponseModel.empty() =>
    SignUpResponseModel(
      code: 0,
      mensaje: '',
    );

}
