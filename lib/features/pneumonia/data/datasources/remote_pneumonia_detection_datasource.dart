import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pneumonia_detection/config/client/api_http_client.dart';
import 'package:pneumonia_detection/config/client/client_config.dart';
import 'package:pneumonia_detection/features/pneumonia/data/models/models.dart';
import 'package:pneumonia_detection/features/pneumonia/domain/datasources/datasources.dart';
import 'package:pneumonia_detection/features/pneumonia/domain/entities/entities.dart';

class RemotePneumoniaDetectionDatasource extends PneumoniaDetectionDatasource {

  RemotePneumoniaDetectionDatasource({
    required ApiHttpClient  apiHttpClient,
  }) : _client = apiHttpClient;

  final ApiHttpClient _client;

  static const _basePath = '/pneumonia';

  @override
  Future<Result<PneumoniaEntity?>> scanRadiography({
    required String documento,
    required File image,
  }) async {

    FormData formData = FormData.fromMap({
      'imagen': await MultipartFile.fromFile(image.path, filename: 'imagen.jpg'),
      'documento': documento,
    });

    // final response = await dio.post(
    //   'http://192.168.100.4:5000/pneumonia/procesar',
    //   data: formData,
    // );

    // return right(PneumoniaEntity.empty());

    final response = await _client.post(
      path: '$_basePath/procesar',
      deserializeResponseFunction: PneumoniaDetectionModel.fromJson,
      payload: formData
    );

    final data = response.flatMap((a) => right(a?.toEntity()));

    return data;
  }
  
}
