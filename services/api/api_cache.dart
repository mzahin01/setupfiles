import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:get/get.dart';

class ApiCache extends GetxService {
  ApiCache({required final String? cachePath}) {
    cacheStore = HiveCacheStore(cachePath, hiveBoxName: 'api_cache');
  }
  static ApiCache get to => Get.find<ApiCache>();
  late final HiveCacheStore cacheStore;
}
