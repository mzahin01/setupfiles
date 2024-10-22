import 'package:flutter/material.dart';

extension DefaultString on String {
  String get coachPlaceholder =>
      'https://pillar-public-bucket.s3.eu-west-2.amazonaws.com/avatar/other/iconAvatarIcOther@3x.png';
  String get errorPlaceHolder => 'Something went wrong!';
}

extension StringExtenstion on String? {
  bool isNotNullOrEmpty() {
    return this != null && this!.isNotEmpty && this != 'null';
  }
}

extension InitialString on String {
  String initials() {
    String result = '';
    final List<String> words = split(' ');
    for (final element in words) {
      if (element.trim().isNotEmpty && result.length < 2) {
        result += element[0].trim();
      }
    }

    return result.trim().toUpperCase();
  }
}

extension ColorUtil on String {
  Color fromHexToColor({final Color defaultColor = Colors.transparent}) {
    if (isEmpty) {
      return defaultColor;
    }

    final hexString = split('#').last;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
    }
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  Color fromHex6ToColor({final Color defaultColor = Colors.transparent}) {
    if (isEmpty) {
      return defaultColor;
    }

    return Color(
      int.parse(toLowerCase().substring(1, 7), radix: 16) + 0xFF000000,
    );
  }
}
