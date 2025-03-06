// ignore_for_file: depend_on_referenced_packages

import 'package:alice_lightweight/alice.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'api_cache.dart';
import 'interceptors/alice_interceptor.dart';
import 'interceptors/connectivity_interceptor.dart';

class ApiClient extends GetxService with DioMixin {
  ApiClient() {
    httpClientAdapter = HttpClientAdapter();
    options = _baseOption;

    if (dotenv.env['isDebuggingEnabled'] == 'true') {
      interceptors.add(
        PrettyDioLogger(
          responseBody: true,
          requestBody: true,
          error: true,
          compact: true,
        ),
      );
    }

    interceptors.add(DioCacheInterceptor(options: _defaultCacheOption));

    interceptors.add(ConnectivityInterceptor());
    // interceptors.add(RefreshTokenInterceptor());

    if (alice != null) {
      interceptors.add(alice!.getDioInterceptor());
    }
  }

  static ApiClient get to => Get.find<ApiClient>();
  final AliceInterceptor _aliceInterceptor = AliceInterceptor();
  Alice? get alice => _aliceInterceptor.alice;

  CacheOptions get _defaultCacheOption => CacheOptions(
    store: ApiCache.to.cacheStore,
    allowPostMethod: false,
    policy: CachePolicy.forceCache,
    maxStale: const Duration(hours: 48),
    hitCacheOnErrorExcept: <int>[401, 403],
    priority: CachePriority.high,
  );

  Options get defaultOptions => Options(
    headers: {
      // if (UserService.to.token.isNotEmpty)
      //   'Authorization': 'Bearer ${UserService.to.token}',
    },
    extra: _defaultCacheOption.toExtra(),
  );

  Options get forceCacheOption => defaultOptions.copyWith(
    extra:
        _defaultCacheOption.copyWith(policy: CachePolicy.forceCache).toExtra(),
  );

  Options get refreshCacheOption => defaultOptions.copyWith(
    extra:
        _defaultCacheOption
            .copyWith(policy: CachePolicy.refreshForceCache)
            .toExtra(),
  );

  Options get noCacheOption => defaultOptions.copyWith(
    extra: _defaultCacheOption.copyWith(policy: CachePolicy.noCache).toExtra(),
  );

  BaseOptions get _baseOption => BaseOptions(
    baseUrl:
        (dotenv.env['isProdBuild'] == 'true')
            ? 'https://api.themaxlive.com/business'
            : 'https://dev.themaxlive.com/business',
    receiveTimeout: 100.seconds,
    headers: <String, dynamic>{'Content-Type': 'application/json'},
    contentType: 'application/json',
    validateStatus: (final int? status) {
      // if (status == 401) {
      //   UserService.to.logout();
      //   return false;
      // }
      // return true;
      return status != null && status >= 200 && status < 300;
    },
    // validateStatus: (int? status) => true,
    // receiveDataWhenStatusError: true,
  );
}
