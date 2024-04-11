
import 'package:pneumonia_detection/config/client/api_http_client.dart';
import 'package:pneumonia_detection/config/client/client_config.dart';
import 'package:pneumonia_detection/features/pneumonia/domain/datasources/datasources.dart';
import 'package:pneumonia_detection/features/pneumonia/domain/entities/entities.dart';

class RemotePneumoniaDetectionDatasource extends PneumoniaDetectionDatasource {

  RemotePneumoniaDetectionDatasource({
    required ApiHttpClient  apiHttpClient,
  }) : _client = apiHttpClient;

  final ApiHttpClient _client;
  
  @override
  Future<Result<PneumoniaEntity>> scanRadiography({required String documento, required String image}) {
    // TODO: implement scanRadiography
    throw UnimplementedError();
  }
  
}
