import 'dart:io';
import 'package:flutter/foundation.dart';

class BaseUrl {
  static String get api {
    if (kIsWeb) {
      return "http://localhost:5079";
    }

    // Nếu không phải web → kiểm tra platform OS
    if (Platform.isAndroid) {
      // Android Emulator phải dùng 10.0.2.2
      return "http://10.0.2.2:5079";
    }

    // iOS Simulator, macOS, Windows → dùng localhost
      return "http://localhost:5079";
  }
}
