# Standardize f53_settings.dart Layout and Theme

This plan addresses the missing theme constants and layout inconsistencies in `f53_settings.dart` to match the standardized structure established in `f20_home_dashboard.dart`.

## User Review Required

> [!IMPORTANT]
> This will re-introduce the `_cPrimary`, `_cTextPrimary`, etc., constants to the file and replace hardcoded colors to ensure visual consistency with the rest of the app.

## Proposed Changes

### [MODIFY] [f53_settings.dart](file:///C:/Users/user/Downloads/CAPSTONE/project/lib/screens/f53_settings.dart)

1.  **Add Theme Constants**: Re-insert the standard color constant block at the top of the file.
2.  **Standardize Bottom Nav**:
    - Update `_buildBottomNav()` to use constants like `_cPrimaryDark` and `_cPrimary`.
    - Update `_NavItem` to use `_cPrimary` for active and `_cTextSecondary` for inactive states.
3.  **Standardize Home Indicator**: Update `_HomeIndicator` to use `_cPrimaryDark`.
4.  **Refactor Body**: Replace remaining hardcoded colors in the `Scaffold` and `body` with the appropriate constants.

## Verification Plan

### Manual Verification
- Verify the screen renders correctly in the Android Studio Preview.
- Confirm the navigation bar matches `f20_home_dashboard.dart` exactly.
