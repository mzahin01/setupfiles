import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import '../../shared/extension/debouncer.dart';
import '../../shared/widget/bottom_sheet/bottom_sheet_util.dart';

class ConnectivityService extends GetxService {
  static ConnectivityService get to => Get.find();
  bool _isConnectivityErrorBottomSheetOpen = false;
  bool get isNetworkConnected => _connectivityResult != ConnectivityResult.none;
  late final StreamSubscription<List<ConnectivityResult>>? _subscription;
  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  final Debouncer _initDebouncer = 3000.millisecondDebouncer;
  final Debouncer _errorDebouncer = 500.millisecondDebouncer;
  final Debouncer _apiDebouncer = 500.millisecondDebouncer;

  @override
  void onInit() {
    Connectivity().checkConnectivity().then(
      (final value) => _connectivityResult = value.first,
    );
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _initDebouncer.call(() async {
      _subscription = Connectivity().onConnectivityChanged.listen((
        final List<ConnectivityResult> result,
      ) {
        _connectivityResult = result.first;
        checkInternet();
        if (isNetworkConnected) {
          // DriveTestSyncService.to?.synchronize();
        }
      });
    });
  }

  void checkInternet({final bool shouldReload = false}) {
    _errorDebouncer.call(() {
      if (_connectivityResult == ConnectivityResult.none) {
        _clearAllAlert();
        if (!_isConnectivityErrorBottomSheetOpen) {
          _isConnectivityErrorBottomSheetOpen = true;
          BottomSheetUtil.to
              .showConfirm(
                // header: Center(
                //   child: SvgPicture.asset(SVGAsset.no_internet),
                // ),
                title: 'No Internet',
                description: 'No internet description',
                buttonTitle: 'Reload',
                onPressed: () {
                  Get.back();
                  checkInternet(shouldReload: true);
                },
              )
              .whenComplete(() => _isConnectivityErrorBottomSheetOpen = false);
        }
      } else {
        if (Get.isBottomSheetOpen ?? false) {
          if (_isConnectivityErrorBottomSheetOpen) {
            _isConnectivityErrorBottomSheetOpen = false;
            Get.back();
          }
        }
        if (shouldReload) {
          _apiDebouncer.call(() {
            // HomeController.to?.onReload();
          });
        }
      }
    });
  }

  @override
  void onClose() {
    _errorDebouncer.cancel();
    _initDebouncer.cancel();
    _apiDebouncer.cancel();
    _subscription?.cancel();
    super.onClose();
  }

  void _clearAllAlert() {
    if (Get.isBottomSheetOpen == true ||
        Get.isDialogOpen == true ||
        Get.isSnackbarOpen == true) {
      Get.back();
    }
  }
}
