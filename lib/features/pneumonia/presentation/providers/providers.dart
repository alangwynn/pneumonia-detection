
import 'package:pneumonia_detection/features/pneumonia/data/datasources/datasources.dart';
import 'package:pneumonia_detection/features/pneumonia/data/repositories/repositories.dart';
import 'package:pneumonia_detection/features/pneumonia/domain/repositories/repositories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
PneumoniaDetectionRepository pneumoniaDetectionRepository(PneumoniaDetectionRepositoryRef ref) {
  
  final mockDatsource = MockPneumoniaDetectionDatasource();

  return PneumoniaDetectionRepositoryImpl(
    datasource: mockDatsource,
  );

}
