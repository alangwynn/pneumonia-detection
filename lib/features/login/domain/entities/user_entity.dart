
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  
  const UserEntity({
    this.admin = false,
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

  factory UserEntity.empty() =>
    const UserEntity(
      apellido: '',
      createdAt: '',
      documento: '',
      email: '',
      id: 0,
      nombre: '',
    );

  @override
  List<Object?> get props => [admin, apellido, createdAt, documento, email, id, nombre];

}
