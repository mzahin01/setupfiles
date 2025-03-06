import '../../shared/model/base_response/base_response.dart';
import '../../shared/util/url_generator.dart';
import '../api/rest_api.dart';

class PushNotificationApi extends RestApi {
  Future<bool> saveFCMToken({
    required final String? oldToken,
    required final String? newToken,
  }) async {
    final String url = UrlGenerator.getUrl(path: 'notification/device-token');
    final BaseResponse response = await post(
      url,
      noCache: true,
      data: <String, dynamic>{
        'old_token': oldToken == newToken ? null : oldToken,
        'new_token': newToken,
        'token_type': 'FCM',
      },
    );
    if (response.error == true) {
      throw response.message ?? '';
    }
    return !(response.error ?? true);
  }
}
