import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:demo_project/app/core/config/environment.dart';
import 'package:demo_project/app/core/constants/app_constants.dart';
import 'package:demo_project/app/core/network/api_exception.dart';
import 'package:demo_project/app/core/network/connectivity_service.dart';
import 'package:demo_project/app/core/storage/storage_service.dart';
import 'package:demo_project/app/core/utils/logger.dart';

class BaseApiService {
  static final BaseApiService _instance = BaseApiService._internal();
  factory BaseApiService() => _instance;
  BaseApiService._internal();

  final http.Client _client = http.Client();
  final StorageService _storage = StorageService();
  final ConnectivityService _connectivity = ConnectivityService();

  Map<String, String> get _headers {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    final token = _storage.getToken();
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Uri _buildUri(String endpoint, {Map<String, dynamic>? queryParams}) {
    final uri = Uri.parse('${EnvironmentConfig.baseUrl}$endpoint');
    if (queryParams != null) {
      return uri.replace(queryParameters: queryParams.map(
        (key, value) => MapEntry(key, value.toString()),
      ));
    }
    return uri;
  }

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? extraHeaders,
  }) async {
    return _request(
      () => _client.get(
        _buildUri(endpoint, queryParams: queryParams),
        headers: {..._headers, ...?extraHeaders},
      ),
    );
  }

  Future<dynamic> post(
    String endpoint, {
    dynamic body,
    Map<String, String>? extraHeaders,
  }) async {
    return _request(
      () => _client.post(
        _buildUri(endpoint),
        headers: {..._headers, ...?extraHeaders},
        body: body != null ? jsonEncode(body) : null,
      ),
    );
  }

  Future<dynamic> put(
    String endpoint, {
    dynamic body,
    Map<String, String>? extraHeaders,
  }) async {
    return _request(
      () => _client.put(
        _buildUri(endpoint),
        headers: {..._headers, ...?extraHeaders},
        body: body != null ? jsonEncode(body) : null,
      ),
    );
  }

  Future<dynamic> patch(
    String endpoint, {
    dynamic body,
    Map<String, String>? extraHeaders,
  }) async {
    return _request(
      () => _client.patch(
        _buildUri(endpoint),
        headers: {..._headers, ...?extraHeaders},
        body: body != null ? jsonEncode(body) : null,
      ),
    );
  }

  Future<dynamic> delete(
    String endpoint, {
    Map<String, String>? extraHeaders,
  }) async {
    return _request(
      () => _client.delete(
        _buildUri(endpoint),
        headers: {..._headers, ...?extraHeaders},
      ),
    );
  }

  Future<dynamic> _request(
    Future<http.Response> Function() request,
  ) async {
    if (!await _connectivity.hasConnection) {
      throw ApiException.noInternet();
    }
    try {
      final response = await request().timeout(
        Duration(seconds: AppConstants.connectTimeout),
      );

      AppLogger.network('=======> Method: ${response.request?.method} \n url : ${response.request?.url} \n  -----> status Code ${response.statusCode} \n ========> ${response.body} ');

      return _processResponse(response);
    } on TimeoutException {
      throw ApiException.timeout();
    } on SocketException {
      AppLogger.error('Socket error', error: request);
      throw ApiException(message: 'Could not connect to server');
    } on ApiException {
      rethrow;
    } catch (e) {
      AppLogger.error('Network error', error: e);
      throw ApiException.unknown(e);
    }
  }

  dynamic _processResponse(http.Response response) {
    dynamic body;
    if (response.body.isNotEmpty) {
      try {
        body = jsonDecode(response.body);
      } catch (e) {
        body = response.body; // Fallback to raw string if it's not valid JSON
      }
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    }

    throw ApiException.fromStatusCode(response.statusCode, body);
  }

  Future<dynamic> postMultipart(
    String endpoint, {
    Map<String, String>? fields,
    Map<String, File>? files,
    Map<String, String>? extraHeaders,
  }) async {
    if (!await _connectivity.hasConnection) {
      throw ApiException.noInternet();
    }
    try {
      final request = http.MultipartRequest('POST', _buildUri(endpoint));
      
      final headers = {..._headers, ...?extraHeaders};
      headers.remove('Content-Type'); // Let http client set the correct content type with boundary
      request.headers.addAll(headers);

      if (fields != null) {
        request.fields.addAll(fields);
      }

      if (files != null) {
        for (var entry in files.entries) {
          request.files.add(
            await http.MultipartFile.fromPath(
              entry.key,
              entry.value.path,
            ),
          );
        }
      }

      final streamedResponse = await request.send().timeout(
        Duration(seconds: AppConstants.connectTimeout),
      );
      final response = await http.Response.fromStream(streamedResponse);
      
      AppLogger.network('=======> Method: POST (Multipart) \n url : ${response.request?.url} \n  -----> status Code ${response.statusCode} \n ========> ${response.body} ');

      return _processResponse(response);
    } on TimeoutException {
      throw ApiException.timeout();
    } on SocketException {
      throw ApiException(message: 'Could not connect to server');
    }
  }

  Future<dynamic> patchMultipart(
    String endpoint, {
    Map<String, String>? fields,
    Map<String, File>? files,
    Map<String, String>? extraHeaders,
  }) async {
    if (!await _connectivity.hasConnection) {
      throw ApiException.noInternet();
    }
    try {
      final request = http.MultipartRequest('PATCH', _buildUri(endpoint));
      
      final headers = {..._headers, ...?extraHeaders};
      headers.remove('Content-Type'); // Let http client set the correct content type with boundary
      request.headers.addAll(headers);

      if (fields != null) {
        request.fields.addAll(fields);
      }

      if (files != null) {
        for (var entry in files.entries) {
          request.files.add(
            await http.MultipartFile.fromPath(
              entry.key,
              entry.value.path,
            ),
          );
        }
      }

      final streamedResponse = await request.send().timeout(
        Duration(seconds: AppConstants.connectTimeout),
      );
      final response = await http.Response.fromStream(streamedResponse);
      
      AppLogger.network('=======> Method: PATCH (Multipart) \n url : ${response.request?.url} \n  -----> status Code ${response.statusCode} \n ========> ${response.body} ');

      return _processResponse(response);
    } on TimeoutException {
      throw ApiException.timeout();
    } on SocketException {
      throw ApiException(message: 'Could not connect to server');
    } on ApiException {
      rethrow;
    } catch (e) {
      AppLogger.error('Network error', error: e);
      throw ApiException.unknown(e);
    }
  }
}
