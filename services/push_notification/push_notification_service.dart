import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../../shared/const/enums.dart';
import '../snackbar/snackbar_notification.dart';
import '../storage/storage_box.dart';
import 'push_notification_api.dart';

Future<void> onBackgroundNotificationResponse(
  final NotificationResponse response,
) async {
  if (Get.isRegistered<PushNotificationService>()) {
    await PushNotificationService.to.processIncomingNotification(
      jsonDecode(response.payload ?? ''),
    );
  }
}

class PushNotificationService extends GetxService {
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'pillar-push-notification',
    'High Importance Notifications',
    importance: Importance.high,
  );
  static PushNotificationService get to => Get.find();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  late final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  final String _notificationIcon = '@mipmap/ic_launcher';

  PushNotificationService() : super() {
    _initFirebasePushNotification();
  }

  Future<void> forceUploadDeviceToken() async {
    try {
      final String oldToken = StorageBox.to.fcmToken;
      final String newToken = await _fcm.getToken() ?? '';
      debugPrint('fcm_token $newToken');
      if (newToken.isNotEmpty) {
        StorageBox.to.setFCMToken(fcmToken: newToken);
        unawaited(
          PushNotificationApi().saveFCMToken(
            newToken: newToken,
            oldToken: oldToken,
          ),
        );
      }
    } catch (e) {
      SnackbarNotification.to.error(error: e.toString());
    }
  }

  Future<void> processIncomingNotification(
    final Map<String, dynamic> message, {
    final bool isInitialMessage = false,
  }) async {
    final Map<String, dynamic> data = message;
    if (data['action_type'] != null &&
        int.tryParse(data['action_type']) ==
            NotificationActionType.ROUTE.index) {
      StorageBox.to.setPushNotifications(notification: jsonEncode(message));
      // if (UserService.to.isAuthed) {
      //   // pop until Routes.home
      //   Get.until((final route) => route.isFirst);
      //   // unawaited(HomeController.to?.checkForPendingNotification());
      // }
    }
  }

  Future<void> _initFirebasePushNotification() async {
    _initializeNotificationsPlugin();
    await _fcm.setAutoInitEnabled(true);
    if (Platform.isIOS) {
      await _fcm.requestPermission(alert: true, badge: true, sound: true);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await _fcm.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    await _fcm.getInitialMessage().then((final RemoteMessage? event) {
      if (event != null) {
        processIncomingNotification(event.data, isInitialMessage: true);
      }
    });

    FirebaseMessaging.onMessage.listen((final RemoteMessage event) async {
      if (Platform.isAndroid) {
        await _flutterLocalNotificationsPlugin.show(
          0,
          event.notification?.title ?? '',
          event.notification?.body ?? '',
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              importance: Importance.high,
              priority: Priority.high,
              icon: _notificationIcon,
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          payload: jsonEncode(event.data),
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((final RemoteMessage event) {
      unawaited(processIncomingNotification(event.data));
    });

    _fcm.onTokenRefresh.listen((final String event) {
      unawaited(forceUploadDeviceToken());
    });

    _uploadDeviceToken();
  }

  void _initializeNotificationsPlugin() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(_notificationIcon);
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          onBackgroundNotificationResponse,
    );
  }

  Future<void> _onNotificationResponse(
    final NotificationResponse response,
  ) async {
    await processIncomingNotification(jsonDecode(response.payload ?? ''));
  }

  Future<void> _uploadDeviceToken() async {
    try {
      final String oldToken = StorageBox.to.fcmToken;
      await _fcm.getToken().then((final String? newToken) async {
        debugPrint('fcm_token $newToken');
        if (newToken != oldToken && newToken?.isNotEmpty == true) {
          StorageBox.to.setFCMToken(fcmToken: newToken!);
          // if (UserService.to.isAuthed) {
          //   unawaited(
          //     PushNotificationApi().saveFCMToken(
          //       newToken: newToken,
          //       oldToken: oldToken,
          //     ),
          //   );
          // }
        }
      });
    } catch (e) {
      SnackbarNotification.to.error(error: e.toString());
    }
  }
}
