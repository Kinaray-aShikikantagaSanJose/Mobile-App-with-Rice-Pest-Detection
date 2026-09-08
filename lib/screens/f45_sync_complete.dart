import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import '../app_router.dart';

@Preview(name: 'F45SyncComplete', size: Size(390.0, 844.0))
Widget previewF45SyncComplete() {
	return const MaterialApp(
		debugShowCheckedModeBanner: false,
		home: F45SyncComplete(recordId: 'REC123'),
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
const Color _cGreenLight    = Color(0xFFD8F3DC);

const double _hPad = 24.0;

// ------------------------------------------------------------------
// F45SyncComplete
// ------------------------------------------------------------------
class F45SyncComplete extends StatefulWidget {
	final String recordId;
	const F45SyncComplete({super.key, required this.recordId});

	@override
	F45SyncCompleteState createState() => F45SyncCompleteState();
}

class F45SyncCompleteState extends State<F45SyncComplete> {
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
									children: [
										const SizedBox(height: 12),
										const SizedBox(height: 80),
										_buildSuccessBadge(),
										const SizedBox(height: 23),
										_buildSuccessText(),
										const SizedBox(height: 24),
										_buildDetailsCard(),
									],
								),
							),
						),
						Padding(
							padding: const EdgeInsets.symmetric(horizontal: _hPad),
							child: Column(
								children: [
									_buildReturnHomeButton(),
									const SizedBox(height: 12),
									_buildViewAllScansButton(),
								],
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

	Widget _buildSuccessBadge() {
		return Container(
			width: 80,
			height: 80,
			decoration: const BoxDecoration(
				color: _cGreenLight,
				shape: BoxShape.circle,
			),
			child: const Icon(Icons.check, color: _cPrimary, size: 40),
		);
	}

	Widget _buildSuccessText() {
		return const Column(
			children: [
				Text(
					'Data Saved Successfully',
					textAlign: TextAlign.center,
					style: TextStyle(
						color: _cTextPrimary,
						fontSize: 28,
						fontWeight: FontWeight.bold,
					),
				),
				SizedBox(height: 8),
				Text(
					'Your field analysis is securely stored in cloud and synced.',
					textAlign: TextAlign.center,
					style: TextStyle(
						color: _cTextSecondary,
						fontSize: 15,
					),
				),
			],
		);
	}

	Widget _buildDetailsCard() {
		return Container(
			width: double.infinity,
			padding: const EdgeInsets.all(20),
			decoration: BoxDecoration(
				color: _cSurface,
				borderRadius: BorderRadius.circular(16),
				border: Border.all(color: _cBorder, width: 1),
			),
			child: const Column(
				children: [
					_DetailRow(label: 'Scan ID', value: 'RPD-2026-0847'),
					_Divider(),
					_DetailRow(label: 'Saved Database', value: 'PostgreSQL Cloud'),
					_Divider(),
					_DetailRow(label: 'Sync Timestamp', value: 'Aug 16, 2026 • 10:45 AM'),
				],
			),
		);
	}

	Widget _buildReturnHomeButton() {
		return InkWell(
			onTap: () => context.go(AppRouter.home),
			borderRadius: BorderRadius.circular(100),
			child: Container(
				width: double.infinity,
				padding: const EdgeInsets.symmetric(vertical: 18),
				decoration: BoxDecoration(
					color: _cPrimary,
					borderRadius: BorderRadius.circular(100),
				),
				child: const Text(
					'Return to Home',
					textAlign: TextAlign.center,
					style: TextStyle(
						color: _cSurface,
						fontSize: 15,
						fontWeight: FontWeight.bold,
					),
				),
			),
		);
	}

	Widget _buildViewAllScansButton() {
		return InkWell(
			onTap: () => debugPrint('View All Scans pressed'),
			borderRadius: BorderRadius.circular(100),
			child: Container(
				width: double.infinity,
				padding: const EdgeInsets.symmetric(vertical: 18),
				decoration: BoxDecoration(
					border: Border.all(color: _cBorder, width: 1),
					borderRadius: BorderRadius.circular(100),
				),
				child: const Text(
					'View All Scans',
					textAlign: TextAlign.center,
					style: TextStyle(
						color: _cTextPrimary,
						fontSize: 15,
						fontWeight: FontWeight.bold,
					),
				),
			),
		);
	}
}

// ------------------------------------------------------------------
// Reusable Widgets
// ------------------------------------------------------------------

class _DetailRow extends StatelessWidget {
	final String label;
	final String value;
	const _DetailRow({required this.label, required this.value});

	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: const EdgeInsets.symmetric(vertical: 6),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children: [
					Text(
						label,
						style: const TextStyle(
							color: _cTextSecondary,
							fontSize: 13,
						),
					),
					Text(
						value,
						style: const TextStyle(
							color: _cTextPrimary,
							fontSize: 13,
							fontWeight: FontWeight.bold,
						),
					),
				],
			),
		);
	}
}

class _Divider extends StatelessWidget {
	const _Divider();

	@override
	Widget build(BuildContext context) {
		return Container(
			height: 1,
			width: double.infinity,
			color: _cBorder,
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