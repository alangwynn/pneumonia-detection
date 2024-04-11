import 'package:fpdart/fpdart.dart';
import 'package:pneumonia_detection/config/types/types.dart';
import 'package:pneumonia_detection/exceptions/exceptions.dart';

typedef Result<T> = Either<ApiException, T>;

abstract class IHttpClient {
  Future<Result<T?>> get<T extends Object>({
    required String path,
    required DeserializeFromJson<T> deserializeResponseFunction,
    Map<String, String>? queryParams,
    Map<String, Object> payload,
    String contentType,
    String? baseUrl,
  });

  @Deprecated('Use get instead with deserializeResponseFunctionList parameter.')
  Future<Result<T?>> getList<T extends List<dynamic>>({
    required String path,
    required DeserializeFromJsonList<T> deserializeResponseFunctionList,
    Map<String, String>? queryParams,
    Map<String, Object>? payload,
    String contentType = 'application/json',
    String? baseUrl,
  });

  Future<Result<T?>> post<T extends Object>({
    required String path,
    DeserializeFromJson<T> deserializeResponseFunction,
    DeserializeFromJsonList<T> deserializeResponseFunctionList,
    Object? payload,
    Map<String, String>? queryParams,
    String contentType,
    String? baseUrl,
  });

  Future<Result<T?>> put<T extends Object>({
    required String path,
    required Object payload,
    DeserializeFromJson<T> deserializeResponseFunction,
    String contentType,
    String? baseUrl,
  });

  Future<Result<None>> delete({
    required String path,
    String? baseUrl,
  });
}
