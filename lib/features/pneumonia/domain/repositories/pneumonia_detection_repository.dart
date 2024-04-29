import 'dart:io';

import 'package:pneumonia_detection/config/client/client_config.dart';
import 'package:pneumonia_detection/features/pneumonia/domain/entities/entities.dart';

abstract class PneumoniaDetectionRepository {

  Future<Result<PneumoniaEntity?>> scanRadiography({
    required String documento,
    required File image,
    required String userId,
  });

}
