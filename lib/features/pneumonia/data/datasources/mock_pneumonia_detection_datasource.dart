
import 'package:fpdart/fpdart.dart';
import 'package:pneumonia_detection/config/client/client_config.dart';
import 'package:pneumonia_detection/exceptions/exceptions.dart';
import 'package:pneumonia_detection/features/pneumonia/data/models/pneumonia_detection_model.dart';
import 'package:pneumonia_detection/features/pneumonia/domain/datasources/datasources.dart';
import 'package:pneumonia_detection/features/pneumonia/domain/entities/entities.dart';

class MockPneumoniaDetectionDatasource extends PneumoniaDetectionDatasource {

  @override
  Future<Result<PneumoniaEntity>> scanRadiography({
    required String documento,
    required String image,
  }) async {

    const error = ApiException(code: '200', message: 'Error');
    
    final response = PneumoniaDetectionModel(
      code: 200,
      message: 'Escaneo exitoso',
      data: const PneumoniaEntity(
        mensaje: 'Paciente con neumonía',
        porcentaje: '0.95',
        recomendacion: 'Asistir a un centro médico',
      ),
    );

    return right(response.toEntity());
  }
  
}
