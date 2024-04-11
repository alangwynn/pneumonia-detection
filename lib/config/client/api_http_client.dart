import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pneumonia_detection/config/broadcast/error_broadcast.dart';
import 'package:pneumonia_detection/config/client/client_config.dart';
import 'package:pneumonia_detection/config/client/pretty_dio_logger.dart';
import 'package:pneumonia_detection/config/console/console_logger.dart';
import 'package:pneumonia_detection/config/storage_manager/storage_manager.dart';
import 'package:pneumonia_detection/config/token/token_repository.dart';
import 'package:pneumonia_detection/config/types/types.dart' as marshalling;
import 'package:pneumonia_detection/exceptions/exceptions.dart';

/// A concrete implementation of [IHttpClient] that uses the [Dio] package.
/// This implementation is a singleton.
final class ApiHttpClient implements IHttpClient {
  factory ApiHttpClient() {
    assert(
        _instance != null,
        'ApiHttpClient not initialized. Call ApiHttpClient.initialize() '
        'first.');
    return _instance!;
  }

  factory ApiHttpClient.initialize({
    required String baseUrl,
    Dio? dioClient,
    TokenRepository? tokenRepository,
    Duration connectionTimeout = const Duration(seconds: 10),
    Duration receiveTimeout = const Duration(seconds: 10),
  }) {
    if (_instance != null) {
      return _instance!;
    }
    return _instance = ApiHttpClient._internal(
      connectionTimeout: connectionTimeout,
      receiveTimeout: receiveTimeout,
      dioClient: dioClient,
      tokenRepository: tokenRepository,
      baseUrl: baseUrl,
    );
  }

  ApiHttpClient._internal({
    required this.baseUrl,
    required Duration connectionTimeout,
    required Duration receiveTimeout,
    Dio? dioClient,
    TokenRepository? tokenRepository,
  }) {
    log(
      'Initializing ApiHttpClient with baseUrl: $baseUrl',
      name: 'ApiHttpClient',
    );
    //* Basic dio configuration
    final options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: connectionTimeout,
      receiveTimeout: receiveTimeout,
      contentType: 'application/json',
    );
    httpClient = dioClient ?? Dio(options);

    //* Interceptors section
    tokenRepository?.getAuthToken();
    httpClient.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final authToken =
              await StorageManager().getString(key: 'access_token');
          if (authToken != null) {
            options.headers['Authorization'] = authToken;
          }

          return handler.next(options);
        },
      ),
    );
    httpClient.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
      ),
    );
    log('ApiHttpClient initialized', name: 'ApiHttpClient');
  }
  final String baseUrl;

  static ApiHttpClient? _instance;

  // Supported HTTP methods
  static const getMethod = 'GET';
  static const postMethod = 'POST';
  static const deleteMethod = 'DELETE';
  static const putMethod = 'PUT';

  late Dio httpClient;

  /// A generic request method that handles all HTTP methods.
  Future<Result<T?>> _request<T>({
    required String method,
    required String path,
    required String contentType,
    Object? payload,
    Map<String, String>? queryParams,
    Map<String, dynamic>? customHeaders,
    marshalling.DeserializeFromJson<T>? deserializeResponseFunction,
    marshalling.DeserializeFromJsonList<T>? deserializeResponseFunctionList,
    String? baseUrl,
  }) async {
    if (deserializeResponseFunction == null &&
        deserializeResponseFunctionList == null) {
      throw Exception('Provide one of '
          'deserializeResponseFunction or deserializeResponseFunctionList');
    }

    if (deserializeResponseFunction != null &&
        deserializeResponseFunctionList != null) {
      throw Exception('Only one of '
          'deserializeResponseFunction or deserializeResponseFunctionList '
          'should be provided');
    }

    //* If base baseUrl wasn't set, use baseUrl
    final url = baseUrl ?? this.baseUrl;

    if (!(url.startsWith('http://') || url.startsWith('https://'))) {
      throw Exception('Wrong base url format. Should be http o https.');
    }

    //* Create Uri from Url
    final uri = url.startsWith('http://')
        ? Uri.http(
            url.replaceAll('http://', ''),
            path,
          )
        : Uri.https(
            url.replaceAll('https://', ''),
            path,
          );
    log(
      'Request: $method $uri' ' query params: $queryParams',
      name: 'ApiHttpClient',
    );

    final dioOptions = Options(
      headers: customHeaders,
    );

    Response<String> response;
    try {
      switch (method) {
        case getMethod:
          response = await httpClient.get<String>(
            uri.toString(),
            queryParameters: queryParams,
            options: dioOptions,
          );
        case postMethod:
          httpClient.options.contentType = contentType;
          httpClient.options.headers['Content-Type'] = contentType;
          response = await httpClient.post<String>(
            uri.toString(),
            data: jsonEncode(payload),
            queryParameters: queryParams,
            options: dioOptions,
          );
        case putMethod:
          httpClient.options.contentType = contentType;
          httpClient.options.headers['Content-Type'] = contentType;
          response = await httpClient.put<String>(
            uri.toString(),
            data: jsonEncode(payload),
            queryParameters: queryParams,
            options: dioOptions,
          );
        case deleteMethod:
          response = await httpClient.delete<String>(
            uri.toString(),
            data: jsonEncode(payload),
            queryParameters: queryParams,
            options: dioOptions,
          );
        default:
          log(
            'Unsupported HTTP Method',
            name: 'ApiHttpClient',
          );
          throw Exception('Unsupported HTTP Method');
      }
    } on Exception catch (e, stackTrace) {
      ErrorBroadcastChannel().eventSink.add(
            ClientErrorSimpleEvent(
              message: e.toString(),
              errorType: ErrorSimpleEventErrorType.unknownException,
              stackTrace: stackTrace,
            ),
          );
      console.error(
        'Error: $method $uri $e',
        name: 'ApiHttpClient',
      );
      return left(
        ApiException(
          message: e.toString(),
        ),
      );
    }

    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      T responseObject;
      dynamic data;

      try {
        data = jsonDecode(response.data!);
      } catch (e, stackTrace) {
        const message = 'The response body is not a valid JSON';
        ErrorBroadcastChannel().eventSink.add(
              ClientErrorSimpleEvent(
                message: message,
                errorType: ErrorSimpleEventErrorType.malformedResponseException,
                stackTrace: stackTrace,
              ),
            );
        console.error(
          message,
          name: 'ApiHttpClient',
        );
        return left(
          ApiException(
            message: message,
          ),
        );
      }

      //* If the response is a list, map each element to the deserializer
      //* function, otherwise just use the deserializer function
      if (data is List<dynamic> && deserializeResponseFunctionList != null) {
        responseObject = deserializeResponseFunctionList(data);
        return right(responseObject);
      }
      if (data is Map<String, dynamic> && deserializeResponseFunction != null) {
        responseObject = deserializeResponseFunction(data);
        return right(responseObject);
      }
      const message = 'Response body is not a Map or List';
      ErrorBroadcastChannel().eventSink.add(
            ClientErrorSimpleEvent(
              message: message,
              errorType: ErrorSimpleEventErrorType.malformedResponseException,
            ),
          );
      console.error(
        message,
        name: 'ApiHttpClient',
      );
      return left(
        ApiException(
          message: message,
        ),
      );
    } else if (response.statusCode == HttpStatus.noContent ||
        response.statusCode == HttpStatus.accepted) {
      if (deserializeResponseFunction != null ||
          deserializeResponseFunctionList != null) {
        return left(
          ApiException(
            message: 'Cannot deserialize no content or accepted response',
          ),
        );
      }
      // Empty response code.
      return right(null);
    } else {
      return left(
        ApiException(
          message: response.statusMessage ?? '',
          code: response.statusCode.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<T?>> get<T extends Object>({
    required String path,
    marshalling.DeserializeFromJson<T>? deserializeResponseFunction,
    marshalling.DeserializeFromJsonList<T>? deserializeResponseFunctionList,
    Map<String, String>? queryParams,
    Map<String, dynamic>? payload,
    Map<String, dynamic>? customHeaders,
    String contentType = 'application/json',
    String? baseUrl,
  }) async {
    return _request(
      method: getMethod,
      path: path,
      queryParams: queryParams,
      customHeaders: customHeaders,
      payload: payload,
      deserializeResponseFunction: deserializeResponseFunction,
      deserializeResponseFunctionList: deserializeResponseFunctionList,
      contentType: contentType,
      baseUrl: baseUrl,
    );
  }

  @Deprecated('Use get instead with deserializeResponseFunctionList parameter.')
  @override
  Future<Result<T?>> getList<T extends List<dynamic>>({
    required String path,
    required marshalling.DeserializeFromJsonList<T>
        deserializeResponseFunctionList,
    Map<String, String>? queryParams,
    Map<String, dynamic>? customHeaders,
    Map<String, dynamic>? payload,
    String contentType = Headers.jsonContentType,
    String? baseUrl,
  }) async {
    return _request(
      method: getMethod,
      path: path,
      payload: payload,
      queryParams: queryParams,
      customHeaders: customHeaders,
      deserializeResponseFunctionList: deserializeResponseFunctionList,
      contentType: contentType,
    );
  }

  @override
  Future<Result<T?>> post<T extends Object>({
    required String path,
    marshalling.DeserializeFromJson<T>? deserializeResponseFunction,
    marshalling.DeserializeFromJsonList<T>? deserializeResponseFunctionList,
    Map<String, dynamic>? customHeaders,
    Object? payload,
    Map<String, String>? queryParams,
    String contentType = 'application/json',
    String? baseUrl,
  }) {
    return _request(
      method: postMethod,
      path: path,
      payload: payload,
      queryParams: queryParams,
      customHeaders: customHeaders,
      deserializeResponseFunction: deserializeResponseFunction,
      deserializeResponseFunctionList: deserializeResponseFunctionList,
      contentType: contentType,
      baseUrl: baseUrl,
    );
  }

  @override
  Future<Result<None>> delete({
    required String path,
    Map<String, dynamic>? customHeaders,
    String? baseUrl,
  }) async {
    final response = await _request<None>(
      method: deleteMethod,
      customHeaders: customHeaders,
      path: path,
      contentType: '',
    );
    return response.flatMap(
      (a) => a == null ? left(ApiException.nullValueResponse) : right(a),
    );
  }

  @override
  Future<Result<T?>> put<T extends Object>({
    required String path,
    required Object payload,
    marshalling.DeserializeFromJson<T>? deserializeResponseFunction,
    marshalling.DeserializeFromJsonList<T>? deserializeResponseFunctionList,
    Map<String, dynamic>? customHeaders,
    String contentType = 'application/json',
    String? baseUrl,
  }) async {
    return _request(
      method: putMethod,
      path: path,
      payload: payload,
      customHeaders: customHeaders,
      deserializeResponseFunction: deserializeResponseFunction,
      deserializeResponseFunctionList: deserializeResponseFunctionList,
      contentType: contentType,
    );
  }
}