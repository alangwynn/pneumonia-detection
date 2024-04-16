
import 'package:pneumonia_detection/config/client/api_http_client.dart';
import 'package:pneumonia_detection/features/pneumonia/data/datasources/datasources.dart';
import 'package:pneumonia_detection/features/pneumonia/data/repositories/repositories.dart';
import 'package:pneumonia_detection/features/pneumonia/domain/repositories/repositories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
PneumoniaDetectionRepository pneumoniaDetectionRepository(PneumoniaDetectionRepositoryRef ref) {
  
  final mockDatsource = MockPneumoniaDetectionDatasource();

  final client = ApiHttpClient();

  final remoteDatasource = RemotePneumoniaDetectionDatasource(apiHttpClient: client);

  return PneumoniaDetectionRepositoryImpl(
    datasource: remoteDatasource,
  );

}
