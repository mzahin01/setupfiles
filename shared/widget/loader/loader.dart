import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Loader {
  const Loader._();

  static Widget circle({final double size = 32}) {
    return Padding(
      padding: const EdgeInsets.only(top: 00),
      child: SizedBox(
        width: Get.width,
        height: Get.width,
        child: Lottie.asset(
          'assets/jsons/loader.json', // Path to the Lottie animation
          fit: BoxFit.contain, // Adjust the fit to the container
        ),
      ),
    );
  }
}
