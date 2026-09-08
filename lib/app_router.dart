import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'auth_controller.dart';
import 'screens/f10_splash_welcome.dart';
import 'screens/f11a_registration.dart';
import 'screens/f11b_otp_verification.dart';
import 'screens/f12a_login.dart';
import 'screens/f12b_session_auth.dart';
import 'screens/f20_home_dashboard.dart';
import 'screens/f31_camera_ui.dart';
import 'screens/f32_image_captured.dart';
import 'screens/f33_gps_field_notes.dart';
import 'screens/f34a_offline_router.dart';
import 'screens/f34b_online_router.dart';
import 'screens/f41_preprocessing.dart';
import 'screens/f42_yolo_v8_analysis.dart';
import 'screens/f43_severity_score.dart';
import 'screens/f44_results_summary.dart';
import 'screens/f45_sync_complete.dart';
import 'screens/f51_spread_map.dart';
import 'screens/f52_periodic_analytics.dart';
import 'screens/f53_settings.dart';

class AppRouter {
  AppRouter(this.auth);

  final AuthController auth;

  static const splash = '/splash';
  static const register = '/register';
  static const otp = '/otp-verification';
  static const login = '/login';
  static const sessionAuth = '/session-auth';
  static const home = '/home';
  static const camera = '/observation/camera';
  static const imageCaptured = '/observation/image-captured';
  static const fieldNotes = '/observation/field-notes';
  static const offlineRouter = '/observation/offline-router';
  static const onlineRouter = '/observation/online-router';
  static const preprocessing = '/observation/preprocessing';
  static const yoloAnalysis = '/observation/yolo-analysis';
  static const severityScore = '/observation/severity-score';
  static const resultsSummary = '/observation/results-summary';
  static const syncComplete = '/observation/sync-complete';
  static const spreadMap = '/spread-map';
  static const periodicAnalytics = '/periodic-analytics';
  static const settings = '/settings';

  late final GoRouter router = GoRouter(
    initialLocation: splash,
    refreshListenable: auth,
    routes: [
      GoRoute(
        path: splash,
        builder: (_, __) => const F10SplashWelcome(),
      ),
      GoRoute(
        path: register,
        builder: (_, __) => const F11aRegistration(),
      ),
      GoRoute(
        path: otp,
        builder: (context, state) => F11bOtpVerification(
          contact: state.extra as String? ?? '',
        ),
      ),
      GoRoute(
        path: login,
        builder: (_, __) => const F12aLogin(),
      ),
      GoRoute(
        path: sessionAuth,
        builder: (_, __) => const F12bSessionAuth(),
      ),
      GoRoute(
        path: home,
        builder: (_, __) => const F20HomeDashboard(),
      ),
      GoRoute(
        path: camera,
        builder: (_, __) => const F31CameraUi(),
      ),
      GoRoute(
        path: imageCaptured,
        builder: (context, state) => F32ImageCaptured(
          imagePath: state.extra as String? ?? '',
        ),
      ),
      GoRoute(
        path: fieldNotes,
        builder: (context, state) => F33GpsFieldNotes(
          imagePath: state.extra as String? ?? '',
        ),
      ),
      GoRoute(
        path: offlineRouter,
        builder: (context, state) => F34aOfflineRouter(
          observation: state.extra,
        ),
      ),
      GoRoute(
        path: onlineRouter,
        builder: (context, state) => F34bOnlineRouter(
          observation: state.extra,
        ),
      ),
      GoRoute(
        path: preprocessing,
        builder: (context, state) => F41Preprocessing(
          observation: state.extra,
        ),
      ),
      GoRoute(
        path: yoloAnalysis,
        builder: (context, state) => F42Yolov8Analysis(
          observation: state.extra,
        ),
      ),
      GoRoute(
        path: severityScore,
        builder: (context, state) => F43SeverityScore(
          detection: state.extra,
        ),
      ),
      GoRoute(
        path: resultsSummary,
        builder: (context, state) => F44ResultsSummary(
          detection: state.extra,
        ),
      ),
      GoRoute(
        path: syncComplete,
        builder: (context, state) => F45SyncComplete(
          recordId: state.extra as String? ?? '',
        ),
      ),
      GoRoute(
        path: spreadMap,
        builder: (_, __) => const F51SpreadMap(),
      ),
      GoRoute(
        path: periodicAnalytics,
        builder: (_, __) => const F52PeriodicAnalytics(),
      ),
      GoRoute(
        path: settings,
        builder: (_, __) => const F53Settings(),
      ),
    ],
    redirect: (context, state) => null,
  );
}
