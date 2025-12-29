import 'dart:io';

class ApiConfig {
  static String get baseUrl {
    if (Platform.isAndroid && !Platform.environment.containsKey('ANDROID_EMULATOR')) {
      // Téléphone Android réel
      return "http://192.168.11.107:8000";
    }

    // Android Emulator
    if (Platform.isAndroid) {
      return "http://10.0.2.2:8000";
    }

    // Autres plateformes
    return "http://localhost:8000";
  }
}
