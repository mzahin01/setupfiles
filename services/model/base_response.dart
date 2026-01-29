class BaseResponse {
  final bool error;
  final String? message;
  final dynamic data;

  BaseResponse({this.error = false, this.message, this.data});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      error: json['error'] ?? false,
      message: json['message'],
      data: json['data'],
    );
  }

  factory BaseResponse.error({String? message}) {
    return BaseResponse(error: true, message: message, data: null);
  }

  Map<String, dynamic> toJson() {
    return {'error': error, 'message': message, 'data': data};
  }
}
