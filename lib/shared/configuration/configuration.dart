import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Configuration {
  // GENERAL FIREBASE CONFIGURATION
  static String get vapidKey => _get('VAPID_KEY');
  static String get messagingSenderId => _get('MESSAGING_SENDER_ID');
  static String get projectId => _get('PROJECT_ID');
  static String get storageBucket => _get('STORAGE_BUCKET');
  static String get serverKey => _get('SERVER_KEY');
  static String get notificationUrl => _get('NOTIFICATION_URL');

  // WEB FIREBASE CONFIGURATION
  static String get webApiKey => _get('WEB_API_KEY');
  static String get webAppId => _get('WEB_APP_ID');
  static String get webAuthDomain => _get('WEB_AUTH_DOMAIN');
  static String get webMeasurementId => _get('WEB_MEASUREMENT_ID');

  // ANDROID FIREBASE CONFIGURATION
  static String get androidApiKey => _get('ANDROID_API_KEY');
  static String get androidAppId => _get('ANDROID_APP_ID');

  // IOS FIREBASE CONFIGURATION
  static String get iosApiKey => _get('IOS_API_KEY');
  static String get iosAppId => _get('IOS_APP_ID');
  static String get iosClientId => _get('IOS_CLIENT_ID');
  static String get iosBundleId => _get('IOS_BUNDLE_ID');

  static String _get(String key) => dotenv.get(key, fallback: "");
}
