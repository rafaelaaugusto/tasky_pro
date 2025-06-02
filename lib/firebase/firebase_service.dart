import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class FirebaseService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  /// Dispara um evento customizado para o Firebase Analytics
  static Future<void> logEvent({
    required String name,
    Map<String, dynamic>? parameters,
  }) async {
    try {
      await _analytics.logEvent(
        name: name,
        parameters: parameters,
      );
    } catch (e, s) {
      print('[Firebase] Falha ao enviar evento: $e');
      _crashlytics.recordError(e, s, reason: 'Falha no logEvent: $name');
    }
  }

  /// Força um crash (para teste apenas)
  static void crashNow() {
    _crashlytics.crash();
  }

  /// Registra um erro sem crashar o app
  static Future<void> recordError(dynamic error, StackTrace stack,
      {String? reason}) async {
    await _crashlytics.recordError(error, stack, reason: reason);
  }
}
