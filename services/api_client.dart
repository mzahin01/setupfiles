import 'dart:convert';

import 'package:alice_lightweight/alice.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../shared/util/log_message.dart';

class ApiClientForRest {
  ApiClientForRest() {
    // Initialize Alice with navigation key
    alice = Alice();

    // Create HTTP client
    client = http.Client();
  }
  static const int timeoutRequest = 60;
  late final Alice alice;
  late final http.Client client;

  final Map<String, String> _mainHeaders = {
    'Content-Type': 'application/json',
    'Vary': 'Accept',
  };

  ///get http request supported
  Future<http.Response> getData({
    required String url,
    Uri? uri,
    String? token,
    Map<String, String>? headers,
    int? timeOut,
  }) async {
    if (uri != null) {
      logMessage(title: "parse uri", message: uri);
    } else {
      logMessage(title: "parse url", message: Uri.parse(url));
    }

    http.Response response = await http
        .get(
          uri ?? Uri.parse(url),
          headers:
              headers ??
              (token != null ? currentUserHeader(token) : _mainHeaders),
        )
        .timeout(
          Duration(seconds: timeOut ?? timeoutRequest),
          onTimeout: () {
            return http.Response(
              addedErrorMessage(),
              408,
            ); // Replace 500 with your http code.
          },
        );

    alice.onHttpResponse(response, body: response.body);

    logMessage(
      title: 'get response url: ${uri ?? Uri.parse(url)}',
      message: response.body,
    );
    return response;
  }

  static Map<String, String> currentUserHeader(String token) {
    Map<String, String> mainHeaders = {
      'Content-Type': 'application/json',
      'Vary': 'Accept',
      'Authorization': 'Bearer $token',
    };
    return mainHeaders;
  }

  String addedErrorMessage({String message = 'error'}) {
    return '{"error": "$message"}';
  }

  Future<http.Response> postData({
    required String url,
    dynamic body,
    String? token,
    Map<String, String>? headers,
    int? timeOut,
  }) async {
    logMessage(title: 'post url', message: url);
    logMessage(title: 'post body', message: jsonEncode(body));
    logMessage(title: 'post token', message: token);

    http.Response response = await http
        .post(
          Uri.parse(url),
          body: jsonEncode(body),
          headers:
              headers ??
              (token != null ? currentUserHeader(token) : _mainHeaders),
        )
        .timeout(
          Duration(seconds: timeOut ?? timeoutRequest),
          onTimeout: () {
            return http.Response(
              addedErrorMessage(),
              408,
            ); // Replace 500 with your http code.
          },
        );

    logMessage(
      title: 'post response url: ${Uri.parse(url)}',
      message: response.body,
    );
    return response;
  }

  /// delete http request supported
  Future<http.Response> deleteData({
    required String url,
    String? token,
    Map<String, String>? headers,
    int? timeOut,
  }) async {
    http.Response response = await http
        .delete(
          Uri.parse(url),
          headers:
              headers ??
              (token != null ? currentUserHeader(token) : _mainHeaders),
        )
        .timeout(
          Duration(seconds: timeOut ?? timeoutRequest),
          onTimeout: () {
            return http.Response(
              addedErrorMessage(),
              408,
            ); // Replace 500 with your http code.
          },
        );
    logMessage(
      title: 'post response url: ${Uri.parse(url)}',
      message: response.body,
    );
    return response;
  }

  ///put http request supported
  Future<http.Response> putData({
    required String url,
    dynamic body,
    String? token,
    Map<String, String>? headers,
    int? timeOut,
  }) async {
    http.Response response = await http
        .put(
          Uri.parse(url),
          body: jsonEncode(body),
          headers:
              headers ??
              (token != null ? currentUserHeader(token) : _mainHeaders),
        )
        .timeout(
          Duration(seconds: timeOut ?? timeoutRequest),
          onTimeout: () {
            return http.Response(
              addedErrorMessage(),
              408,
            ); // Replace 500 with your http code.
          },
        );
    logMessage(
      title: 'post response url: ${Uri.parse(url)}',
      message: response.body,
    );

    return response;
  }
}
