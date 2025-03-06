import 'package:alice_lightweight/alice.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/route_manager.dart';

class AliceInterceptor {
  Alice? get alice => _alice;
  final Alice? _alice = dotenv.env['isDebuggingEnabled'] == 'true'
      ? Alice(
          navigatorKey: Get.key,
        )
      : null;
}
