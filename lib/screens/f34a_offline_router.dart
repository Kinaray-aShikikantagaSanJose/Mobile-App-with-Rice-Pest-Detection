import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import '../app_router.dart';

@Preview(name: 'F34aOfflineRouter', size: Size(390.0, 844.0))
Widget previewF34aOfflineRouter() {
	return const MaterialApp(
		debugShowCheckedModeBanner: false,
		home: F34aOfflineRouter(observation: null),
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
const Color _cOrangeLight   = Color(0xFFFDF2E9);
const Color _cGreenLight    = Color(0xFFD8F3DC);

const double _hPad = 24.0;

// ------------------------------------------------------------------
// F34aOfflineRouter
// ------------------------------------------------------------------
class F34aOfflineRouter extends StatefulWidget {
	final dynamic observation;
	const F34aOfflineRouter({super.key, this.observation});

	@override
	F34aOfflineRouterState createState() => F34aOfflineRouterState();
}

class F34aOfflineRouterState extends State<F34aOfflineRouter> {
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
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										const SizedBox(height: 12),
										_buildOfflineBanner(),
										const SizedBox(height: 10),
										Padding(
											padding: const EdgeInsets.symmetric(horizontal: _hPad),
											child: _buildHeader(),
										),
										const SizedBox(height: 22),
										Padding(
											padding: const EdgeInsets.symmetric(horizontal: _hPad),
											child: _buildSuccessCard(),
										),
										const SizedBox(height: 20),
										Padding(
											padding: const EdgeInsets.symmetric(horizontal: _hPad),
											child: _buildSyncQueueStatus(),
										),
										const SizedBox(height: 100),
									],
								),
							),
						),
						Padding(
							padding: const EdgeInsets.fromLTRB(_hPad, 12, _hPad, 0),
							child: _PrimaryButton(
								label: 'Return to Home',
								onTap: () => context.go(AppRouter.home),
							),
						),
						const SizedBox(height: 16),
						const _HomeIndicator(),
						const SizedBox(height: 8),
					],
				),
			),
		);
	}

	Widget _buildOfflineBanner() {
		return Container(
			width: double.infinity,
			padding: const EdgeInsets.symmetric(vertical: 12, horizontal: _hPad),
			color: _cOrangeLight,
			child: Row(
				children: [
					Icon(Icons.wifi_off, size: 18, color: _cOrange),
					const SizedBox(width: 10),
					const Text(
						'No Internet Connection',
						style: TextStyle(
							color: _cOrange,
							fontSize: 13,
							fontWeight: FontWeight.bold,
						),
					),
				],
			),
		);
	}

	Widget _buildHeader() {
		return Row(
			children: [
				_BackButton(onTap: () => context.pop()),
				const SizedBox(width: 12),
				const Text(
					'Scan Status',
					style: TextStyle(
						color: _cTextPrimary,
						fontSize: 20,
						fontWeight: FontWeight.bold,
					),
				),
			],
		);
	}

	Widget _buildSuccessCard() {
		return Container(
			padding: const EdgeInsets.symmetric(vertical: 24, horizontal: _hPad),
			decoration: BoxDecoration(
				color: _cSurface,
				borderRadius: BorderRadius.circular(32),
				border: Border.all(color: _cBorder, width: 1),
			),
			child: Column(
				children: [
					Container(
						width: 64,
						height: 64,
						decoration: BoxDecoration(
							color: _cGreenLight,
							shape: BoxShape.circle,
							border: Border.all(color: _cPrimary, width: 2),
						),
						child: const Icon(
							Icons.check,
							size: 32,
							color: _cPrimary,
						),
					),
					const SizedBox(height: 20),
					const Text(
						'Scan Saved Locally',
						style: TextStyle(
							color: _cTextPrimary,
							fontSize: 22,
							fontWeight: FontWeight.bold,
						),
					),
					const SizedBox(height: 8),
					Text(
						'The insect sticky trap scan has been recorded and safely stored in the local database.',
						textAlign: TextAlign.center,
						style: TextStyle(
							color: _cTextSecondary,
							fontSize: 14,
							height: 1.4,
						),
					),
					const SizedBox(height: 20),
					Divider(color: _cBorder, height: 1),
					const SizedBox(height: 20),
					_buildInfoRow(
						icon: Icons.storage_outlined,
						text: 'Stored in local database',
					),
					const SizedBox(height: 12),
					_buildInfoRow(
						icon: Icons.sync_outlined,
						text: 'Will sync automatically when online',
					),
				],
			),
		);
	}

	Widget _buildInfoRow({required IconData icon, required String text}) {
		return Row(
			children: [
				Icon(icon, size: 16, color: _cTextSecondary),
				const SizedBox(width: 8),
				Text(
					text,
					style: TextStyle(
						color: _cTextSecondary,
						fontSize: 13,
					),
				),
			],
		);
	}

	Widget _buildSyncQueueStatus() {
		return Container(
			padding: const EdgeInsets.all(16),
			decoration: BoxDecoration(
				color: _cOrangeLight,
				borderRadius: BorderRadius.circular(20),
			),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children: [
					Row(
						children: [
							Icon(Icons.format_list_bulleted, size: 20, color: _cOrange),
							const SizedBox(width: 10),
							const Text(
								'Sync Queue Status',
								style: TextStyle(
									color: _cOrange,
									fontSize: 14,
									fontWeight: FontWeight.bold,
								),
							),
						],
					),
					const Text(
						'3 scans pending',
						style: TextStyle(
							color: _cOrange,
							fontSize: 13,
							fontWeight: FontWeight.bold,
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

class _BackButton extends StatelessWidget {
	final VoidCallback onTap;
	const _BackButton({required this.onTap});

	@override
	Widget build(BuildContext context) {
		return InkWell(
			onTap: onTap,
			borderRadius: BorderRadius.circular(20),
			child: Container(
				width: 40,
				height: 40,
				decoration: BoxDecoration(
					color: _cSurface,
					shape: BoxShape.circle,
					border: Border.all(color: _cBorder, width: 1),
				),
				child: const Icon(
					Icons.arrow_back_ios_new,
					size: 16,
					color: _cTextPrimary,
				),
			),
		);
	}
}

class _PrimaryButton extends StatelessWidget {
	final String label;
	final VoidCallback onTap;

	const _PrimaryButton({
		required this.label,
		required this.onTap,
	});

	@override
	Widget build(BuildContext context) {
		return InkWell(
			onTap: onTap,
			borderRadius: BorderRadius.circular(100),
			child: Container(
				width: double.infinity,
				padding: const EdgeInsets.symmetric(vertical: 18),
				decoration: BoxDecoration(
					color: _cPrimary,
					borderRadius: BorderRadius.circular(100),
				),
				alignment: Alignment.center,
				child: Text(
					label,
					style: const TextStyle(
						color: _cSurface,
						fontSize: 15,
						fontWeight: FontWeight.bold,
					),
				),
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