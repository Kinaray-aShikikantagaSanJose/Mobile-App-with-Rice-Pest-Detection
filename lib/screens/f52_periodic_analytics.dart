import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import '../app_router.dart';

@Preview(name: 'F52PeriodicAnalytics', size: Size(390.0, 844.0))
Widget previewF52PeriodicAnalytics() {
	return const MaterialApp(
		debugShowCheckedModeBanner: false,
		home: F52PeriodicAnalytics(),
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
const Color _cOrange        = Color(0xFFE67E22);
const Color _cGreenLight    = Color(0xFFD8F3DC);
const Color _cDanger        = Color(0xFFE63946);
const Color _cSuccess       = Color(0xFF10B981);

const double _hPad = 24.0;

// ------------------------------------------------------------------
// F52PeriodicAnalytics
// ------------------------------------------------------------------
class F52PeriodicAnalytics extends StatefulWidget {
	const F52PeriodicAnalytics({super.key});

	@override
	F52PeriodicAnalyticsState createState() => F52PeriodicAnalyticsState();
}

class F52PeriodicAnalyticsState extends State<F52PeriodicAnalytics> {
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
										const Text(
											'Field Insights',
											style: TextStyle(
												color: _cTextPrimary,
												fontSize: 20,
												fontWeight: FontWeight.bold,
											),
										),
										const SizedBox(height: 12),
										const _InsightsTabBar(activeIndex: 3),
										const SizedBox(height: 16),
										_buildWeeklyComparisonCard(),
										const SizedBox(height: 16),
										_buildEntryPointCard(),
										const SizedBox(height: 16),
										_buildTreatmentImpactCard(),
										const SizedBox(height: 16),
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
											isActive: false,
											onTap: () => context.go(AppRouter.home),
										),
										_NavItem(
											icon: Icons.format_list_bulleted,
											label: 'Scans',
											isActive: false,
											onTap: () {},
										),
										const SizedBox(width: 56),
										_NavItem(
											icon: Icons.map_outlined,
											label: 'Map',
											isActive: true,
											onTap: () => context.go(AppRouter.spreadMap),
										),
										_NavItem(
											icon: Icons.settings_outlined,
											label: 'Settings',
											isActive: false,
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

	Widget _buildWeeklyComparisonCard() {
		return _Card(
			padding: const EdgeInsets.all(16),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Row(
						children: [
							const Text(
								'WEEKLY SCAN COMPARISONS',
								style: TextStyle(
									color: _cTextSecondary,
									fontSize: 12,
									fontWeight: FontWeight.bold,
								),
							),
							const Spacer(),
							_buildPeriodToggle(),
						],
					),
					const SizedBox(height: 20),
					SizedBox(
						height: 110,
						child: Row(
							crossAxisAlignment: CrossAxisAlignment.end,
							children: const [
								_BarColumn(value: '48', label: 'W1', height: 0, color: _cDanger),
								_BarColumn(value: '32', label: 'W2', height: 50, color: _cOrange),
								_BarColumn(value: '20', label: 'W3', height: 30, color: _cSuccess),
								_BarColumn(value: '42', label: 'W4 (Today)', height: 65, color: _cDanger),
							],
						),
					),
				],
			),
		);
	}

	Widget _buildPeriodToggle() {
		return Container(
			padding: const EdgeInsets.all(2),
			decoration: BoxDecoration(
				color: _cBackground,
				borderRadius: BorderRadius.circular(100),
			),
			child: Row(
				children: [
					Container(
						padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
						decoration: BoxDecoration(
							color: _cPrimary,
							borderRadius: BorderRadius.circular(100),
						),
						child: const Text(
							'Weekly',
							style: TextStyle(color: _cSurface, fontSize: 10, fontWeight: FontWeight.bold),
						),
					),
					const Padding(
						padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
						child: Text(
							'Monthly',
							style: TextStyle(color: _cTextSecondary, fontSize: 10),
						),
					),
				],
			),
		);
	}

	Widget _buildEntryPointCard() {
		return _Card(
			padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					const Text(
						'PEST ENTRY POINT STATS',
						style: TextStyle(
							color: _cTextSecondary,
							fontSize: 12,
							fontWeight: FontWeight.bold,
						),
					),
					const SizedBox(height: 16),
					Row(
						crossAxisAlignment: CrossAxisAlignment.center,
						children: [
							_buildEntryPointDial(),
							const SizedBox(width: 16),
							const Expanded(
								child: Column(
									children: [
										_BoundaryRow(label: 'East Boundary', percent: '45%', color: _cDanger, bold: true),
										SizedBox(height: 6),
										_BoundaryRow(label: 'North Boundary', percent: '35%', color: _cOrange, bold: true),
										SizedBox(height: 6),
										_BoundaryRow(label: 'South Boundary', percent: '12%', color: _cTextSecondary, bold: false),
										SizedBox(height: 6),
										_BoundaryRow(label: 'West Boundary', percent: '8%', color: _cTextSecondary, bold: false),
									],
								),
							),
						],
					),
				],
			),
		);
	}

	Widget _buildEntryPointDial() {
		return SizedBox(
			width: 80,
			height: 80,
			child: Stack(
				alignment: Alignment.center,
				children: [
					Container(
						decoration: BoxDecoration(
							shape: BoxShape.circle,
							border: Border.all(color: _cBorder, width: 6),
						),
					),
					const Icon(Icons.north_east, color: _cDanger, size: 26),
					const Positioned(
						top: 4,
						right: 8,
						child: Text(
							'45%',
							style: TextStyle(color: _cDanger, fontSize: 10, fontWeight: FontWeight.bold),
						),
					),
				],
			),
		);
	}

	Widget _buildTreatmentImpactCard() {
		return Container(
			width: double.infinity,
			padding: const EdgeInsets.all(16),
			decoration: BoxDecoration(
				color: _cGreenLight,
				borderRadius: BorderRadius.circular(16),
			),
			child: Row(
				children: [
					Container(
						width: 32,
						height: 32,
						decoration: const BoxDecoration(
							color: _cSurface,
							shape: BoxShape.circle,
						),
						child: const Icon(Icons.trending_down, color: _cPrimary, size: 18),
					),
					const SizedBox(width: 16),
					const Expanded(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Text(
									'Treatment Impact',
									style: TextStyle(
										color: _cTextSecondary,
										fontSize: 12,
										fontWeight: FontWeight.bold,
									),
								),
								SizedBox(height: 2),
								Text(
									'Imidacloprid application reduced count by 62%',
									style: TextStyle(
										color: _cTextPrimary,
										fontSize: 16,
										fontWeight: FontWeight.bold,
									),
								),
							],
						),
					),
				],
			),
		);
	}
}

// ------------------------------------------------------------------
// Reusable Widgets
// ------------------------------------------------------------------

class _InsightsTabBar extends StatelessWidget {
	final int activeIndex;
	const _InsightsTabBar({required this.activeIndex});

	static const List<String> _labels = ['Overview', 'Spread Map', 'Trends', 'Analytics'];

	@override
	Widget build(BuildContext context) {
		return Row(
			children: List.generate(_labels.length, (i) {
				final bool isActive = i == activeIndex;
				return Padding(
					padding: EdgeInsets.only(right: i == _labels.length - 1 ? 0 : 8),
					child: InkWell(
						onTap: () => debugPrint('${_labels[i]} tab pressed'),
						borderRadius: BorderRadius.circular(100),
						child: Container(
							padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
							decoration: BoxDecoration(
								color: isActive ? _cPrimary : _cSurface,
								borderRadius: BorderRadius.circular(100),
								border: isActive ? null : Border.all(color: _cBorder, width: 1),
							),
							child: Text(
								_labels[i],
								style: TextStyle(
									color: isActive ? _cSurface : _cTextSecondary,
									fontSize: 13,
									fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
								),
							),
						),
					),
				);
			}),
		);
	}
}

class _Card extends StatelessWidget {
	final Widget child;
	final EdgeInsets padding;
	const _Card({required this.child, required this.padding});

	@override
	Widget build(BuildContext context) {
		return Container(
			width: double.infinity,
			padding: padding,
			decoration: BoxDecoration(
				color: _cSurface,
				borderRadius: BorderRadius.circular(16),
				border: Border.all(color: _cBorder, width: 1),
			),
			child: child,
		);
	}
}

class _BarColumn extends StatelessWidget {
	final String value;
	final String label;
	final double height;
	final Color color;
	const _BarColumn({
		required this.value,
		required this.label,
		required this.height,
		required this.color,
	});

	@override
	Widget build(BuildContext context) {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.end,
				children: [
					Text(
						value,
						style: const TextStyle(color: _cTextPrimary, fontSize: 11, fontWeight: FontWeight.bold),
					),
					const SizedBox(height: 8),
					Container(
						height: height,
						width: 24,
						decoration: BoxDecoration(
							color: color,
							borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
						),
					),
					const SizedBox(height: 8),
					Text(
						label,
						style: const TextStyle(color: _cTextSecondary, fontSize: 10),
						textAlign: TextAlign.center,
					),
				],
			),
		);
	}
}

class _BoundaryRow extends StatelessWidget {
	final String label;
	final String percent;
	final Color color;
	final bool bold;
	const _BoundaryRow({
		required this.label,
		required this.percent,
		required this.color,
		required this.bold,
	});

	@override
	Widget build(BuildContext context) {
		return Row(
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: [
				Text(label, style: const TextStyle(color: _cTextSecondary, fontSize: 13)),
				Text(
					percent,
					style: TextStyle(
						color: color,
						fontSize: 13,
						fontWeight: bold ? FontWeight.bold : FontWeight.normal,
					),
				),
			],
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

class _HomeIndicator extends StatelessWidget {
	const _HomeIndicator();

	@override
	Widget build(BuildContext context) {
		return const Center(
			child: SizedBox(
				width: 134,
				height: 5,
				child: DecoratedBox(
					decoration: BoxDecoration(
						color: _cPrimaryDark,
						borderRadius: BorderRadius.all(Radius.circular(100)),
					),
				),
			),
		);
	}
}
