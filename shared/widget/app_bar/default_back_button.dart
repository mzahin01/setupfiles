import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../styles/colors.dart';

class DefaultBackButton extends StatelessWidget {
  const DefaultBackButton({super.key});

  @override
  Widget build(final BuildContext context) {
    return IconButton(
      onPressed: Get.back,
      icon: const Icon(
        Icons.arrow_back_ios,
        color: SGColors.black,
      ),
    );
  }
}
