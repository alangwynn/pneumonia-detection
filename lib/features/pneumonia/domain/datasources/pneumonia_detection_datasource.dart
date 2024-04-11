
import 'package:pneumonia_detection/config/client/client_config.dart';
import 'package:pneumonia_detection/features/pneumonia/domain/entities/entities.dart';

abstract class PneumoniaDetectionDatasource {

  Future<Result<PneumoniaEntity>> scanRadiography({
    required String documento,
    required String image,
  });

}
