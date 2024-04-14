
import 'package:equatable/equatable.dart';

class PneumoniaEntity extends Equatable {

  const PneumoniaEntity({
    required this.porcentaje,
    required this.mensaje,
    required this.recomendacion,
  });

  factory PneumoniaEntity.fromJson(Map<String, dynamic> json) {
    return PneumoniaEntity(
      porcentaje: json['porcentaje'] != null ? json['porcentaje'].toString() : '',
      mensaje: json['mensaje'] as String? ?? '',
      recomendacion: json['recomendacion'] as String? ?? '',
    );
  }

  factory PneumoniaEntity.empty() {
    return const PneumoniaEntity(
      porcentaje: '',
      mensaje: '',
      recomendacion: '',
    );
  }

  final String porcentaje;
  final String mensaje;
  final String recomendacion;

  @override
  List<Object?> get props => [porcentaje, mensaje, recomendacion];

  @override
  bool get stringify => true;

}
