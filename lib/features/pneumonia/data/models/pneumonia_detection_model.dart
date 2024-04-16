import 'package:pneumonia_detection/features/pneumonia/domain/entities/entities.dart';

class PneumoniaDetectionModel {
  PneumoniaDetectionModel({
    required this.code,
    required this.message,
    required this.data,
  });

  final int code;
  final String message;
  final PneumoniaEntity data;

  factory PneumoniaDetectionModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return PneumoniaDetectionModel(
      code: json['code'] as int? ?? 0,
      message: json['message'] as String? ?? '',
      data: PneumoniaEntity.fromJson(data as Map<String, dynamic>? ?? {}),
    );
  }

  PneumoniaEntity toEntity() {
    return data;
  }

}
