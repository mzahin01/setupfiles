import 'package:connectivity_plus/connectivity_plus.dart';
// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';

class ConnectivityInterceptor extends Interceptor {
  ConnectivityInterceptor() {
    Connectivity().onConnectivityChanged.listen((
      final List<ConnectivityResult> result,
    ) {
      _connectivityResult = result.first;
    });
  }

  ConnectivityResult? _connectivityResult;

  @override
  Future<dynamic> onRequest(
    final RequestOptions options,
    final RequestInterceptorHandler handler,
  ) async {
    /// Only initialize the connectivity result if it is null
    _connectivityResult ??= (await Connectivity().checkConnectivity()).first;
    if (_connectivityResult == ConnectivityResult.none) {}
    handler.next(options);
  }
}
