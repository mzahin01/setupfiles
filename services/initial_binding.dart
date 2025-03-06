// import 'package:get/get.dart';
// import 'package:maxlive/app/services/api/api_client.dart';
// import 'package:maxlive/app/services/api/connectivity_service.dart';
// import 'package:maxlive/app/services/banned_user_find/banned_user_find.dart';
// import 'package:maxlive/app/services/deep.link.service.dart';
// import 'package:maxlive/app/services/snackbar/snackbar_notification.dart';
// import 'package:maxlive/app/services/storage/storage_box.dart';
// import 'package:maxlive/app/services/upload/image_upload_service.dart';
// import 'package:maxlive/app/services/user/oauth/google_sign_in.dart';
// import 'package:maxlive/app/services/user/user_service.dart';
// import 'package:maxlive/app/shared/widget/bottom_sheet/bottom_sheet_util.dart';

// class InitialBinding extends Bindings {
//   @override
//   Future<void> dependencies() async {
//     Get.put(SnackbarNotification());
//     Get.put(StorageBox());
//     Get.put(ImageUploadService());
//     Get.lazyPut(() => BottomSheetUtil());
//     Get.put(ConnectivityService());
//     Get.put(UserService());
//     Get.put(ApiClient());
//     Get.put(GoogleSocialLogin.instance());
//     Get.put(BannedUserService());
//     // Get.put(PushNotificationService());
//     // Get.put(RTDBSyncService());
//     // Get.put(RemoteConfigService());
//     Get.put(DeepLinkService());
//   }
// }
