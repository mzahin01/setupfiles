import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:readiness_app/app/modules/reaction_test_final_result/model/drive_test_request_model/drive_test_request_model.dart';

class StorageBox extends GetxService {
  static StorageBox get to => Get.find();

  final GetStorage _box = GetStorage()..initStorage;

  // Cache ID
  int? get cacheId => _box.read<int?>(StorageKeys.cacheId.name);
  // FCM Token
  String get fcmToken => _box.read<String?>(StorageKeys.fcmToken.name) ?? '';
  Future<void> clearFCMToken() async =>
      await _box.remove(StorageKeys.fcmToken.name);
  void setFCMToken({required final String fcmToken}) {
    _box.write(StorageKeys.fcmToken.name, fcmToken);
  }

  // Preload Email
  String? get preloadEmail =>
      _box.read<String?>(StorageKeys.preloadEmail.name) ?? '';
  Future<void> clearPreloadEmail() async =>
      await _box.remove(StorageKeys.preloadEmail.name);
  void setPreloadEmail({required final String preloadEmail}) {
    _box.write(StorageKeys.preloadEmail.name, preloadEmail);
  }

  // Push Notification
  String get pushNotifications =>
      _box.read<String?>(StorageKeys.pushNotifications.name) ?? '';

  // Token
  String get token => _box.read<String?>(StorageKeys.token.name) ?? '';
  Future<void> clearToken() async => await _box.remove(StorageKeys.token.name);
  void setToken({required final String token}) {
    _box.write(StorageKeys.token.name, token);
  }

  // Refresh Token
  String get refreshToken =>
      _box.read<String?>(StorageKeys.refreshToken.name) ?? '';

  String? get userId => _box.read<String?>(StorageKeys.userId.name);
  Future<void> setUserId({required final String userId}) async {
    await _box.write(StorageKeys.userId.name, userId);
  }

  Future<void> clearRefreshToken() async =>
      await _box.remove(StorageKeys.refreshToken.name);
  void setRefreshToken({required final String refreshToken}) {
    _box.write(StorageKeys.refreshToken.name, refreshToken);
  }

  void clearCacheId() => _box.remove(StorageKeys.cacheId.name);

  void clearlocale() => _box.remove(StorageKeys.locale.name);
  Future<void> clearPushNotifications() async =>
      await _box.remove(StorageKeys.pushNotifications.name);

  Future<void> closeTips({required final String tag}) async =>
      _box.write(tag, false);

  Future<void> flushBox() async => await _box.save();

  void resetBox() => _box.erase();

  Future<void> resetTips({required final String tag}) async =>
      await _box.remove(tag);

  Future<void> resetUserData() async {
    await clearToken();
    await clearRefreshToken();
    clearFCMToken();
    clearCacheId();
  }

  void setCacheId({required final int cacheId}) {
    _box
        .write(StorageKeys.cacheId.name, cacheId)
        .then((final _) => _box.save());
  }

  void setLocale({required final Locale locale}) {
    _box.write(StorageKeys.locale.name, locale.toString());
  }

  void setPushNotifications({required final String notification}) {
    _box.write(StorageKeys.pushNotifications.name, notification);
  }

  // ToolTip
  Future<bool> shouldShowTips({required final String tag}) async =>
      _box.read<bool?>(tag) ?? true;

  // For Debug use only
  String? getCurrentChannelName() {
    return _box.read<String?>(StorageKeys.currentChannel.name);
  }

  Future<void> setCurrentChannelName({
    required final String? channelName,
  }) async {
    await _box.write(StorageKeys.currentChannel.name, channelName);
  }

  Future<bool> getuserBannedStatus() async {
    return _box.read(StorageKeys.userBannedStatus.name) ?? false;
  }

  Future<void> setUserBannedStatus({required final bool status}) async {
    await _box.write(StorageKeys.userBannedStatus.name, status);
  }

  Future<void> getUserInfo() async {
    return _box.read(StorageKeys.userData.name);
  }

  Future<void> clearUserInfo() async {
    await _box.remove(StorageKeys.userData.name);
  }
}

enum StorageKeys {
  token,
  refreshToken,
  fcmToken,
  locale,
  pushNotifications,
  cacheId,
  preloadEmail,
  currentChannel,
  userBannedStatus,
  userData,
  userId,
}
