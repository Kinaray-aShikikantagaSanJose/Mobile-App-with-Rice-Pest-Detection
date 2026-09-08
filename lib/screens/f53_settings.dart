import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import '../app_router.dart';

@Preview(name: 'F53Settings', size: Size(390.0, 844.0))
Widget previewF53Settings() {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: F53Settings(),
  );
}

// ------------------------------------------------------------------
// Theme Constants (added only for the navbar, matching F20's palette)
// ------------------------------------------------------------------
const Color _cPrimaryDark   = Color(0xFF1B4332);
const Color _cPrimary       = Color(0xFF2D6A4F);
const Color _cSurface       = Color(0xFFFFFFFF);
const Color _cTextSecondary = Color(0xFF5C6B5E);

class F53Settings extends StatefulWidget {
  const F53Settings({super.key});

  @override
  F53SettingsState createState() => F53SettingsState();
}

class F53SettingsState extends State<F53Settings> {
  double _aiThreshold = 85.0;

  // Matches F20's index scheme: 0 Home, 1 Scans, (FAB gap), 3 Map, 4 Settings
  int _selectedNavIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          color: const Color(0xFFFAF8F5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              IntrinsicHeight(
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 24,
                    bottom: 8,
                    left: 24,
                    right: 24,
                  ),
                  width: double.infinity,
                  child: const Text(
                    "Settings",
                    style: TextStyle(
                      color: Color(0xFF1B4332),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SYNC QUEUE
                      IntrinsicHeight(
                        child: Container(
                          padding: const EdgeInsets.only(
                            top: 16,
                            left: 24,
                            right: 24,
                          ),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "SYNC QUEUE",
                                style: TextStyle(
                                  color: Color(0xFF5C6B5E),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Text(
                                "2 pending",
                                style: TextStyle(
                                  color: Color(0xFFE63946),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Sync Item 1
                      IntrinsicHeight(
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 8,
                            left: 24,
                            right: 24,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFE5E0D8),
                              width: 1,
                            ),
                          ),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 12),
                                    width: 20,
                                    height: 20,
                                    child: const Icon(
                                      Icons.description_outlined,
                                      color: Color(0xFF5C6B5E),
                                      size: 20,
                                    ),
                                  ),
                                  const Text(
                                    "RPD-0846 · Field Block A-1",
                                    style: TextStyle(
                                      color: Color(0xFF1B4332),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2D6A4F),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 6,
                                ),
                                child: const Text(
                                  "Retry",
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Sync Item 2
                      IntrinsicHeight(
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 8,
                            left: 24,
                            right: 24,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFE5E0D8),
                              width: 1,
                            ),
                          ),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 12),
                                    width: 20,
                                    height: 20,
                                    child: const Icon(
                                      Icons.description_outlined,
                                      color: Color(0xFF5C6B5E),
                                      size: 20,
                                    ),
                                  ),
                                  const Text(
                                    "RPD-0846 · Field Block A-3",
                                    style: TextStyle(
                                      color: Color(0xFF1B4332),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2D6A4F),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 6,
                                ),
                                child: const Text(
                                  "Retry",
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // FARM MANAGEMENT
                      IntrinsicHeight(
                        child: Container(
                          margin: const EdgeInsets.only(top: 24),
                          padding: const EdgeInsets.only(
                            top: 16,
                            left: 24,
                            right: 24,
                          ),
                          width: double.infinity,
                          child: const Text(
                            "FARM MANAGEMENT",
                            style: TextStyle(
                              color: Color(0xFF5C6B5E),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      // Edit Field Boundaries
                      IntrinsicHeight(
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 8,
                            left: 24,
                            right: 24,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFE5E0D8),
                              width: 1,
                            ),
                          ),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 12),
                                    width: 20,
                                    height: 20,
                                    child: const Icon(
                                      Icons.map_outlined,
                                      color: Color(0xFF5C6B5E),
                                      size: 20,
                                    ),
                                  ),
                                  const Text(
                                    "Edit Field Boundaries",
                                    style: TextStyle(
                                      color: Color(0xFF1B4332),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.chevron_right,
                                color: Color(0xFF5C6B5E),
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Manage Fields
                      IntrinsicHeight(
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 8,
                            left: 24,
                            right: 24,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFE5E0D8),
                              width: 1,
                            ),
                          ),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 12),
                                    width: 20,
                                    height: 20,
                                    child: const Icon(
                                      Icons.format_list_bulleted,
                                      color: Color(0xFF5C6B5E),
                                      size: 20,
                                    ),
                                  ),
                                  const Text(
                                    "Manage Fields",
                                    style: TextStyle(
                                      color: Color(0xFF1B4332),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.chevron_right,
                                color: Color(0xFF5C6B5E),
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // PREFERENCES & SAFETY
                      IntrinsicHeight(
                        child: Container(
                          margin: const EdgeInsets.only(top: 24),
                          padding: const EdgeInsets.only(
                            top: 16,
                            left: 24,
                            right: 24,
                          ),
                          width: double.infinity,
                          child: const Text(
                            "PREFERENCES & SAFETY",
                            style: TextStyle(
                              color: Color(0xFF5C6B5E),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      // Profile Information
                      IntrinsicHeight(
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 8,
                            left: 24,
                            right: 24,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            border: Border.all(
                              color: const Color(0xFFE5E0D8),
                              width: 1,
                            ),
                          ),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 12),
                                    width: 20,
                                    height: 20,
                                    child: const Icon(
                                      Icons.person_outline,
                                      color: Color(0xFF5C6B5E),
                                      size: 20,
                                    ),
                                  ),
                                  const Text(
                                    "Profile Information",
                                    style: TextStyle(
                                      color: Color(0xFF1B4332),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.chevron_right,
                                color: Color(0xFF5C6B5E),
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Notification Preferences
                      IntrinsicHeight(
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 24,
                            right: 24,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            border: Border(
                              left: BorderSide(
                                color: Color(0xFFE5E0D8),
                                width: 1,
                              ),
                              right: BorderSide(
                                color: Color(0xFFE5E0D8),
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Color(0xFFE5E0D8),
                                width: 1,
                              ),
                            ),
                          ),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 12),
                                    width: 20,
                                    height: 20,
                                    child: const Icon(
                                      Icons.notifications_outlined,
                                      color: Color(0xFF5C6B5E),
                                      size: 20,
                                    ),
                                  ),
                                  const Text(
                                    "Notification Preferences",
                                    style: TextStyle(
                                      color: Color(0xFF1B4332),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.chevron_right,
                                color: Color(0xFF5C6B5E),
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // AI Detection Threshold
                      IntrinsicHeight(
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 24,
                            right: 24,
                          ),
                          padding: const EdgeInsets.only(
                            top: 14,
                            bottom: 14,
                            left: 16,
                            right: 16,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                            border: Border.all(
                              color: const Color(0xFFE5E0D8),
                              width: 1,
                            ),
                          ),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(right: 12),
                                        width: 20,
                                        height: 20,
                                        child: const Icon(
                                          Icons.tune,
                                          color: Color(0xFF5C6B5E),
                                          size: 20,
                                        ),
                                      ),
                                      const Text(
                                        "AI Detection Threshold",
                                        style: TextStyle(
                                          color: Color(0xFF1B4332),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${_aiThreshold.toInt()}%",
                                    style: const TextStyle(
                                      color: Color(0xFF1B4332),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: const Color(0xFF2D6A4F),
                                  inactiveTrackColor: const Color(0xFFE5E0D8),
                                  thumbColor: const Color(0xFFFFFFFF),
                                  overlayColor: const Color(0xFF2D6A4F).withOpacity(0.2),
                                  trackHeight: 4,
                                  thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 8,
                                    elevation: 2,
                                  ),
                                ),
                                child: Slider(
                                  value: _aiThreshold,
                                  min: 0,
                                  max: 100,
                                  onChanged: (value) {
                                    setState(() {
                                      _aiThreshold = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Log Out
                      IntrinsicHeight(
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 24,
                            left: 24,
                            right: 24,
                            bottom: 24,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF2F2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFFFD8D8),
                              width: 1,
                            ),
                          ),
                          width: double.infinity,
                          child: InkWell(
                            onTap: () => context.go(AppRouter.login),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  width: 20,
                                  height: 20,
                                  child: const Icon(
                                    Icons.logout,
                                    color: Color(0xFFE63946),
                                    size: 20,
                                  ),
                                ),
                                const Text(
                                  "Log Out of Account",
                                  style: TextStyle(
                                    color: Color(0xFFE63946),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom Navigation Bar — replaced with F20's floating-FAB pattern
              _buildBottomNav(),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // Bottom Navigation — ported from F20HomeDashboard
  // ------------------------------------------------------------------
  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: _cSurface,
        boxShadow: [
          BoxShadow(
            color: _cPrimaryDark.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72,
          child: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavItem(
                      icon: Icons.home_outlined,
                      label: 'Home',
                      isActive: _selectedNavIndex == 0,
                      onTap: () => context.go(AppRouter.home),
                    ),
                    _NavItem(
                      icon: Icons.format_list_bulleted,
                      label: 'Scans',
                      isActive: _selectedNavIndex == 1,
                      onTap: () => setState(() => _selectedNavIndex = 1),
                    ),
                    const SizedBox(width: 56),
                    _NavItem(
                      icon: Icons.map_outlined,
                      label: 'Map',
                      isActive: _selectedNavIndex == 3,
                      onTap: () => context.push(AppRouter.spreadMap),
                    ),
                    _NavItem(
                      icon: Icons.settings_outlined,
                      label: 'Settings',
                      isActive: _selectedNavIndex == 4,
                      onTap: () => setState(() => _selectedNavIndex = 4),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -28,
                child: FloatingActionButton(
                  onPressed: () => context.push(AppRouter.camera),
                  backgroundColor: _cPrimary,
                  elevation: 4,
                  shape: const CircleBorder(),
                  child: const Icon(Icons.camera_alt, color: _cSurface, size: 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------------
// Reusable Widgets
// ------------------------------------------------------------------
class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: isActive ? _cPrimary : _cTextSecondary,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? _cPrimary : _cTextSecondary,
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}