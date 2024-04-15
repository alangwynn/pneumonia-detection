import 'dart:io';

import 'package:pneumonia_detection/config/client/client_config.dart';
import 'package:pneumonia_detection/features/pneumonia/domain/datasources/datasources.dart';
import 'package:pneumonia_detection/features/pneumonia/domain/entities/entities.dart';
import 'package:pneumonia_detection/features/pneumonia/domain/repositories/repositories.dart';

class PneumoniaDetectionRepositoryImpl extends PneumoniaDetectionRepository {

  PneumoniaDetectionRepositoryImpl({
    required this.datasource,
  });

  final PneumoniaDetectionDatasource datasource;

  @override
  Future<Result<PneumoniaEntity?>> scanRadiography({
    required String documento,
    required File image,
  }) {
    return datasource.scanRadiography(
      documento: documento,
      image: image
    );
  }
  
}
