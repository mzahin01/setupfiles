import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import '../../../app/shared/extension/string.dart';
import '../../../app/services/api/api_client.dart';
import '../../shared/model/base_response/base_response.dart';

abstract class RestApi {
  final ApiClient _apiClient = ApiClient.to;
  ApiClient get apiClient => _apiClient;

  Future<BaseResponse> get(
    final String path, {
    final Object? data,
    final Map<String, dynamic>? queryParameters,
    final bool forceRefresh = false,
    final bool noCache = false,
  }) async {
    try {
      final Response<dynamic> response = await _apiClient.get<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options:
            noCache
                ? _apiClient.noCacheOption
                : forceRefresh
                ? _apiClient.refreshCacheOption
                : _apiClient.forceCacheOption,
      );

      final BaseResponse baseResponse = BaseResponse.fromJson(response.data);

      if (baseResponse.error == true) {
        throw baseResponse.message ?? ''.errorPlaceHolder;
      }
      return baseResponse;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return BaseResponse.error(message: 'No internet');
      }
      rethrow;
    } catch (e) {
      return BaseResponse.error(message: e.toString());
    }
  }

  Future<BaseResponse> post(
    final String path, {
    final Object? data,
    final Map<String, dynamic>? queryParameters,
    final bool forceRefresh = false,
    final bool noCache = false,
  }) async {
    try {
      final Response<dynamic> response = await _apiClient.post<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options:
            noCache
                ? _apiClient.noCacheOption
                : forceRefresh
                ? _apiClient.refreshCacheOption
                : _apiClient.forceCacheOption,
      );

      final BaseResponse baseResponse = BaseResponse.fromJson(response.data);

      if (baseResponse.error == true) {
        throw baseResponse.message ?? ''.errorPlaceHolder;
      }
      return baseResponse;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return BaseResponse.error(message: 'No internet');
      }
      rethrow;
    } catch (e) {
      return BaseResponse.error(message: e.toString());
    }
  }

  Future<BaseResponse> patch(
    final String path, {
    final Object? data,
    final Map<String, dynamic>? queryParameters,
    final bool forceRefresh = false,
    final bool noCache = false,
  }) async {
    try {
      final Response<dynamic> response = await _apiClient.patch<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options:
            noCache
                ? _apiClient.noCacheOption
                : forceRefresh
                ? _apiClient.refreshCacheOption
                : _apiClient.forceCacheOption,
      );

      final BaseResponse baseResponse = BaseResponse.fromJson(response.data);

      if (baseResponse.error == true) {
        throw baseResponse.message ?? ''.errorPlaceHolder;
      }
      return baseResponse;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return BaseResponse.error(message: 'No internet');
      }
      rethrow;
    } catch (e) {
      return BaseResponse.error(message: e.toString());
    }
  }

  Future<BaseResponse> uploadFile(
    final String path, {
    required File file,
    required String fileKey,
    final Map<String, dynamic>? data,
    final Map<String, dynamic>? queryParameters,
    final bool forceRefresh = false,
    final bool noCache = false,
  }) async {
    try {
      // Prepare file for upload
      final String fileName = file.path.split('/').last;
      final MultipartFile multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      );

      // Add the file to form data
      final FormData formData = FormData.fromMap({
        fileKey: multipartFile,
        if (data != null) ...data, // Add other data if available
      });

      // Send the upload request
      final Response<dynamic> response = await _apiClient.post<dynamic>(
        path,
        data: formData,
        queryParameters: queryParameters,
        options:
            noCache
                ? _apiClient.noCacheOption
                : forceRefresh
                ? _apiClient.refreshCacheOption
                : _apiClient.forceCacheOption,
      );

      // Parse the response
      final BaseResponse baseResponse = BaseResponse.fromJson(response.data);

      if (baseResponse.error == true) {
        throw baseResponse.message ?? ''.errorPlaceHolder;
      }
      return baseResponse;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return BaseResponse.error(message: 'No internet');
      }
      rethrow;
    } catch (e) {
      return BaseResponse.error(message: e.toString());
    }
  }

  Future<BaseResponse> put(
    final String path, {
    final Object? data,
    final Map<String, dynamic>? queryParameters,
    final bool forceRefresh = false,
    final bool noCache = false,
  }) async {
    try {
      final Response<dynamic> response = await _apiClient.put<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options:
            noCache
                ? _apiClient.noCacheOption
                : forceRefresh
                ? _apiClient.refreshCacheOption
                : _apiClient.forceCacheOption,
      );

      final BaseResponse baseResponse = BaseResponse.fromJson(response.data);

      if (baseResponse.error == true) {
        throw baseResponse.message ?? ''.errorPlaceHolder;
      }
      return baseResponse;
    } catch (e) {
      return BaseResponse.error(message: e.toString());
    }
  }

  Future<BaseResponse> delete(
    final String path, {
    final Object? data,
    final Map<String, dynamic>? queryParameters,
    final bool forceRefresh = false,
    final bool noCache = false,
  }) async {
    try {
      final Response<dynamic> response = await _apiClient.delete<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options:
            noCache
                ? _apiClient.noCacheOption
                : forceRefresh
                ? _apiClient.refreshCacheOption
                : _apiClient.forceCacheOption,
      );

      final BaseResponse baseResponse = BaseResponse.fromJson(response.data);

      if (baseResponse.error == true) {
        throw baseResponse.message ?? ''.errorPlaceHolder;
      }
      return baseResponse;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return BaseResponse.error(message: 'No internet');
      }
      rethrow;
    } catch (e) {
      return BaseResponse.error(message: e.toString());
    }
  }
}
