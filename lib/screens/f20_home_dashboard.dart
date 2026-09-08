import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import '../app_router.dart';

@Preview(name: 'F20HomeDashboard', size: Size(390.0, 844.0))
Widget previewF20HomeDashboard() {
	return const MaterialApp(
		debugShowCheckedModeBanner: false,
		home: F20HomeDashboard(),
	);
}

// ------------------------------------------------------------------
// Theme Constants
// ------------------------------------------------------------------
const Color _cPrimaryDark   = Color(0xFF1B4332);
const Color _cPrimary       = Color(0xFF2D6A4F);
const Color _cBackground    = Color(0xFFFAF8F5);
const Color _cSurface       = Color(0xFFFFFFFF);
const Color _cBorder        = Color(0xFFE5E0D8);
const Color _cTextPrimary   = Color(0xFF1B4332);
const Color _cTextSecondary = Color(0xFF5C6B5E);
const Color _cTextMuted     = Color(0xFF8E9E90);
const Color _cOrange        = Color(0xFFE67E22);
const Color _cGreenLight    = Color(0xFFD8F3DC);

const double _hPad = 24.0;

// ------------------------------------------------------------------
// F20HomeDashboard
// ------------------------------------------------------------------
class F20HomeDashboard extends StatefulWidget {
	const F20HomeDashboard({super.key});

	@override
	F20HomeDashboardState createState() => F20HomeDashboardState();
}

class F20HomeDashboardState extends State<F20HomeDashboard> {
	int _selectedNavIndex = 0;

	@override
	void initState() {
		super.initState();
		SystemChrome.setPreferredOrientations([
			DeviceOrientation.portraitUp,
			DeviceOrientation.portraitDown,
		]);
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: _cBackground,
			body: SafeArea(
				child: Column(
					children: [
						Expanded(
							child: SingleChildScrollView(
								padding: const EdgeInsets.symmetric(horizontal: _hPad),
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										const SizedBox(height: 12),
										_buildProfileHeader(),
										const SizedBox(height: 16),
										_buildFieldSelector(),
										const SizedBox(height: 16),
										_buildWeatherCard(),
										const SizedBox(height: 12),
										_buildCoverageCard(),
										const SizedBox(height: 12),
										_buildStatsRow(),
										const SizedBox(height: 100),
									],
								),
							),
						),
					],
				),
			),
			bottomNavigationBar: _buildBottomNav(),
		);
	}

	// ------------------------------------------------------------------
	// Profile Header
	// ------------------------------------------------------------------
	Widget _buildProfileHeader() {
		return Row(
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: [
				Row(
					children: [
						Container(
							width: 44,
							height: 44,
							decoration: BoxDecoration(
								color: _cGreenLight,
								shape: BoxShape.circle,
								border: Border.all(color: _cBorder, width: 1),
							),
							child: const Icon(Icons.person, size: 24, color: _cPrimary),
						),
						const SizedBox(width: 12),
						Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								const Text(
									'Welcome Back,',
									style: TextStyle(
										color: _cTextSecondary,
										fontSize: 12,
										height: 1.3,
									),
								),
								const SizedBox(height: 2),
								const Text(
									'Juan Dela Cruz',
									style: TextStyle(
										color: _cTextPrimary,
										fontSize: 16,
										fontWeight: FontWeight.bold,
										height: 1.3,
									),
								),
							],
						),
					],
				),
				Container(
					width: 40,
					height: 40,
					decoration: BoxDecoration(
						color: _cSurface,
						shape: BoxShape.circle,
						border: Border.all(color: _cBorder, width: 1),
					),
					child: const Icon(
						Icons.notifications_none,
						size: 20,
						color: _cTextPrimary,
					),
				),
			],
		);
	}

	// ------------------------------------------------------------------
	// Field Selector
	// ------------------------------------------------------------------
	Widget _buildFieldSelector() {
		return InkWell(
			onTap: () => debugPrint('Field selector pressed'),
			borderRadius: BorderRadius.circular(100),
			child: Container(
				padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
				decoration: BoxDecoration(
					color: _cSurface,
					borderRadius: BorderRadius.circular(100),
					border: Border.all(color: _cBorder, width: 1),
				),
				child: Row(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					children: [
						Row(
							children: [
								const Icon(Icons.location_on_outlined,
										size: 20, color: _cPrimary),
								const SizedBox(width: 8),
								const Text(
									'Field Block A-1 (Main Rice Field)',
									style: TextStyle(
										color: _cTextPrimary,
										fontSize: 14,
										fontWeight: FontWeight.bold,
									),
								),
							],
						),
						const Icon(Icons.keyboard_arrow_down,
								size: 20, color: _cTextMuted),
					],
				),
			),
		);
	}

	// ------------------------------------------------------------------
	// Weather + Pest Risk Card
	// ------------------------------------------------------------------
	Widget _buildWeatherCard() {
		return Container(
			padding: const EdgeInsets.all(16),
			decoration: BoxDecoration(
				color: _cGreenLight,
				borderRadius: BorderRadius.circular(20),
			),
			child: Row(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Expanded(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Row(
									children: [
										const Icon(Icons.wb_sunny_outlined,
												size: 18, color: _cTextPrimary),
										const SizedBox(width: 6),
										const Text(
											'Weather Warning',
											style: TextStyle(
												color: _cTextPrimary,
												fontSize: 13,
												fontWeight: FontWeight.bold,
											),
										),
									],
								),
								const SizedBox(height: 8),
								const Text(
									'32°C',
									style: TextStyle(
										color: _cTextPrimary,
										fontSize: 28,
										fontWeight: FontWeight.bold,
										height: 1.2,
									),
								),
								const SizedBox(height: 8),
								const Text(
									'Partly Cloudy • Humidity 78%',
									style: TextStyle(
										color: _cTextSecondary,
										fontSize: 12,
										height: 1.3,
									),
								),
							],
						),
					),
					InkWell(
						onTap: () => debugPrint('Pest risk pressed'),
						borderRadius: BorderRadius.circular(12),
						child: Container(
							padding: const EdgeInsets.all(10),
							decoration: BoxDecoration(
								color: _cSurface,
								borderRadius: BorderRadius.circular(12),
							),
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									const Text(
										'PEST RISK',
										style: TextStyle(
											color: _cOrange,
											fontSize: 11,
											fontWeight: FontWeight.bold,
										),
									),
									const SizedBox(height: 4),
									const Text(
										'High Activity',
										style: TextStyle(
											color: _cTextPrimary,
											fontSize: 14,
											fontWeight: FontWeight.bold,
										),
									),
									const SizedBox(height: 4),
									Text(
										'Due to high humidity',
										style: TextStyle(
											color: _cTextSecondary,
											fontSize: 10,
											height: 1.3,
										),
									),
								],
							),
						),
					),
				],
			),
		);
	}

	// ------------------------------------------------------------------
	// Weekly Field Coverage Card
	// ------------------------------------------------------------------
	Widget _buildCoverageCard() {
		return Container(
			padding: const EdgeInsets.symmetric(vertical: 16),
			decoration: BoxDecoration(
				color: _cSurface,
				borderRadius: BorderRadius.circular(20),
				border: Border.all(color: _cBorder, width: 1),
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Padding(
						padding: const EdgeInsets.symmetric(horizontal: 16),
						child: Row(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							children: [
								const Text(
									'Weekly Field Coverage',
									style: TextStyle(
										color: _cTextPrimary,
										fontSize: 13,
										fontWeight: FontWeight.bold,
									),
								),
								const Text(
									'3 of 5 scans',
									style: TextStyle(
										color: _cPrimary,
										fontSize: 13,
										fontWeight: FontWeight.bold,
									),
								),
							],
						),
					),
					const SizedBox(height: 12),
					Padding(
						padding: const EdgeInsets.symmetric(horizontal: 16),
						child: ClipRRect(
							borderRadius: BorderRadius.circular(4),
							child: Stack(
								children: [
									Container(
										height: 8,
										width: double.infinity,
										color: _cGreenLight,
									),
									FractionallySizedBox(
										widthFactor: 0.6,
										child: Container(
											height: 8,
											decoration: BoxDecoration(
												color: _cPrimary,
												borderRadius: BorderRadius.circular(4),
											),
										),
									),
								],
							),
						),
					),
					const SizedBox(height: 12),
					Padding(
						padding: const EdgeInsets.symmetric(horizontal: 16),
						child: Text(
							'Recommended: 2 more scans before Friday to maintain full coverage',
							style: TextStyle(
								color: _cTextSecondary,
								fontSize: 11,
								height: 1.4,
							),
						),
					),
				],
			),
		);
	}

	// ------------------------------------------------------------------
	// Stats Row
	// ------------------------------------------------------------------
	Widget _buildStatsRow() {
		return Row(
			children: [
				Expanded(
					child: _StatCard(
						label: 'TOTAL SCANS',
						value: '24',
						labelColor: _cTextSecondary,
						valueColor: _cTextPrimary,
					),
				),
				const SizedBox(width: 10),
				Expanded(
					child: _StatCard(
						label: 'ACTIVE ALERTS',
						value: '3',
						labelColor: _cOrange,
						valueColor: _cOrange,
					),
				),
				const SizedBox(width: 10),
				Expanded(
					child: _StatCard(
						label: 'FIELDS',
						value: '4',
						labelColor: _cTextSecondary,
						valueColor: _cTextPrimary,
					),
				),
			],
		);
	}

	// ------------------------------------------------------------------
	// Bottom Navigation
	// ------------------------------------------------------------------
	Widget _buildBottomNav() {
		return Container(
			decoration: BoxDecoration(
				color: _cSurface,
				boxShadow: [
					BoxShadow(
						color: _cPrimaryDark.withValues(alpha: 0.06),
						blurRadius: 12,
						offset: const Offset(0, -4),
					),
				],
			),
			child: SafeArea(
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
											onTap: () {},
										),
										const SizedBox(width: 56),
										_NavItem(
											icon: Icons.map_outlined,
											label: 'Map',
											isActive: _selectedNavIndex == 3,
											onTap: () => context.go(AppRouter.spreadMap),
										),
										_NavItem(
											icon: Icons.settings_outlined,
											label: 'Settings',
											isActive: _selectedNavIndex == 4,
											onTap: () => context.go(AppRouter.settings),
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

class _StatCard extends StatelessWidget {
	final String label;
	final String value;
	final Color labelColor;
	final Color valueColor;

	const _StatCard({
		required this.label,
		required this.value,
		required this.labelColor,
		required this.valueColor,
	});

	@override
	Widget build(BuildContext context) {
		return Container(
			padding: const EdgeInsets.symmetric(vertical: 12),
			decoration: BoxDecoration(
				color: _cSurface,
				borderRadius: BorderRadius.circular(16),
				border: Border.all(color: _cBorder, width: 1),
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Padding(
						padding: const EdgeInsets.only(left: 12, bottom: 4),
						child: Text(
							label,
							style: TextStyle(
								color: labelColor,
								fontSize: 11,
								fontWeight: FontWeight.bold,
							),
						),
					),
					Padding(
						padding: const EdgeInsets.only(left: 12),
						child: Text(
							value,
							style: TextStyle(
								color: valueColor,
								fontSize: 20,
								fontWeight: FontWeight.bold,
							),
						),
					),
				],
			),
		);
	}
}

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