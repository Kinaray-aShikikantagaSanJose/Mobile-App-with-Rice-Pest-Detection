# Implementation Plan: Fix Flutter Previews and UI Side-Effects

This plan addresses the issue where Flutter `@Preview` annotations are not rendering correctly in the IDE. The main causes identified are missing `MaterialApp` context, navigation side-effects in `initState` that crash without a router, and empty global state (like cameras) in a preview context.

## User Review Required

> [!IMPORTANT]
> I will be wrapping all `@Preview` function returns in a `MaterialApp`. This is standard for Flutter Previews to ensure themes and `MediaQuery` work correctly.
> I will also add a `skipSessionCheck` parameter to `F10SplashWelcome` to prevent navigation redirects during previews.

## Proposed Changes

### [Core UI Infrastructure]

#### [MODIFY] [f10_splash_welcome.dart](file:///C:/Users/user/Downloads/CAPSTONE/project/lib/screens/f10_splash_welcome.dart)
- Add `skipSessionCheck` parameter to `F10SplashWelcome` to bypass the redirect in `initState`.
- Wrap the preview return in a `MaterialApp`.

#### [MODIFY] [f12a_login.dart](file:///C:/Users/user/Downloads/CAPSTONE/project/lib/screens/f12a_login.dart)
- Wrap the preview return in a `MaterialApp`.
- Fix the `activeColor` deprecation warning.

#### [MODIFY] [f31_camera_ui.dart](file:///C:/Users/user/Downloads/CAPSTONE/project/lib/screens/f31_camera_ui.dart)
- Update the preview function to provide a `MaterialApp` and potentially mock the `cameras` list if needed (though the current implementation handles empty cameras gracefully).

### [Bulk Preview Wrapping]

#### [MODIFY] Multiple Screen Files
- Iterate through all files in `lib/screens/` that contain `@Preview` and wrap the returned widget in a `MaterialApp`.
- Files include: `f11a_registration.dart`, `f11b_otp_verification.dart`, `f12b_session_auth.dart`, `f20_home_dashboard.dart`, `f32_image_captured.dart`, `f33_gps_field_notes.dart`, `f34a_offline_router.dart`, `f34b_online_router.dart`, `f41_preprocessing.dart`, `f42_yolo_v8_analysis.dart`, `f43_severity_score.dart`, `f44_results_summary.dart`, `f45_sync_complete.dart`, `f51_spread_map.dart`, `f52_periodic_analytics.dart`, `f53_settings.dart`.

## Verification Plan

### Automated Tests
- Run `flutter analyze` to ensure no new errors or warnings are introduced.

### Manual Verification
- The user can verify that the Preview pane in Android Studio now correctly renders the screens without errors.
