
class UserReponseModel {
  UserReponseModel({
    required this.admin,
    required this.apellido,
    required this.createdAt,
    required this.documento,
    required this.email,
    required this.id,
    required this.nombre,
  });

  final bool admin;
  final String apellido;
  final String createdAt;
  final String documento;
  final String email;
  final int id;
  final String nombre;

  factory UserReponseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw const FormatException("JSON data is null");
    }
    return UserReponseModel(
      admin: json['admin'] ?? false,
      apellido: json['apellido'] ?? '',
      createdAt: json['createdAt'] ?? '',
      documento: json['documento'] ?? '',
      email: json['email'] ?? '',
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
    );
  }
}