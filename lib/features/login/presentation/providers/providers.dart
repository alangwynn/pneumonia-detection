
import 'package:pneumonia_detection/config/client/api_http_client.dart';
import 'package:pneumonia_detection/features/login/data/datasources/datasources.dart';
import 'package:pneumonia_detection/features/login/data/domain/repositories.dart';
import 'package:pneumonia_detection/features/login/domain/repositories/repositories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
UserRepository userRepository(UserRepositoryRef ref) {
  
  final client = ApiHttpClient();
  final datasource = UserRemoteDatasource(
    apiHttpClient: client,
  );

  return UserRepositoryImpl(
    datasource: datasource,
  );

}
