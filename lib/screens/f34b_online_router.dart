import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import '../app_router.dart';

@Preview(name: 'F34bOnlineRouter', size: Size(390.0, 844.0))
Widget previewF34bOnlineRouter() {
	return const MaterialApp(
		debugShowCheckedModeBanner: false,
		home: F34bOnlineRouter(observation: null),
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
// F34bOnlineRouter
// ------------------------------------------------------------------
class F34bOnlineRouter extends StatefulWidget {
	final dynamic observation;
	const F34bOnlineRouter({super.key, this.observation});

	@override
	F34bOnlineRouterState createState() => F34bOnlineRouterState();
}

class F34bOnlineRouterState extends State<F34bOnlineRouter>
		with SingleTickerProviderStateMixin {
	late AnimationController _spinController;

	@override
	void initState() {
		super.initState();
		SystemChrome.setPreferredOrientations([
			DeviceOrientation.portraitUp,
			DeviceOrientation.portraitDown,
		]);
		_spinController = AnimationController(
			vsync: this,
			duration: const Duration(seconds: 2),
		)..repeat();

		Future.delayed(const Duration(seconds: 2), () {
			if (mounted) context.go(AppRouter.preprocessing, extra: widget.observation);
		});
	}

	@override
	void dispose() {
		_spinController.dispose();
		super.dispose();
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
										_buildHeader(),
										const SizedBox(height: 22),
										_buildProgressCard(),
										const SizedBox(height: 24),
										_buildStepsCard(),
										const SizedBox(height: 100),
									],
								),
							),
						),
						_buildCancelButton(),
						const SizedBox(height: 16),
						const _HomeIndicator(),
						const SizedBox(height: 8),
					],
				),
			),
		);
	}

	Widget _buildHeader() {
		return const Text(
			'Uploading Scan',
			style: TextStyle(
				color: _cTextPrimary,
				fontSize: 20,
				fontWeight: FontWeight.bold,
			),
		);
	}

	Widget _buildProgressCard() {
		return Container(
			padding: const EdgeInsets.symmetric(vertical: 24),
			decoration: BoxDecoration(
				color: _cSurface,
				borderRadius: BorderRadius.circular(32),
				border: Border.all(color: _cBorder, width: 1),
			),
			child: Column(
				children: [
					SizedBox(
						width: 120,
						height: 120,
						child: Stack(
							alignment: Alignment.center,
							children: [
								SizedBox(
									width: 120,
									height: 120,
									child: CircularProgressIndicator(
										value: 0.65,
										strokeWidth: 6,
										backgroundColor: _cGreenLight,
										valueColor: const AlwaysStoppedAnimation<Color>(_cPrimary),
									),
								),
								const Text(
									'65%',
									style: TextStyle(
										color: _cTextPrimary,
										fontSize: 24,
										fontWeight: FontWeight.bold,
									),
								),
							],
						),
					),
					const SizedBox(height: 24),
					const Text(
						'Uploading to server...',
						style: TextStyle(
							color: _cTextPrimary,
							fontSize: 16,
							fontWeight: FontWeight.bold,
						),
					),
					const SizedBox(height: 6),
					Text(
						'Estimated time remaining: ~30 seconds',
						style: TextStyle(
							color: _cTextSecondary,
							fontSize: 12,
						),
					),
				],
			),
		);
	}

	Widget _buildStepsCard() {
		return Container(
			padding: const EdgeInsets.only(top: 20, bottom: 20, right: 20),
			decoration: BoxDecoration(
				color: _cSurface,
				borderRadius: BorderRadius.circular(24),
				border: Border.all(color: _cBorder, width: 1),
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					const Padding(
						padding: EdgeInsets.only(left: 20, bottom: 16),
						child: Text(
							'Upload Steps',
							style: TextStyle(
								color: _cTextSecondary,
								fontSize: 12,
								fontWeight: FontWeight.bold,
							),
						),
					),
					_StepItem(
						icon: Icons.check_circle,
						iconColor: _cPrimary,
						text: 'Image uploaded',
						textColor: _cTextPrimary,
						isBold: true,
					),
					_StepItem(
						icon: Icons.check_circle,
						iconColor: _cPrimary,
						text: 'GPS data sent',
						textColor: _cTextPrimary,
						isBold: true,
					),
					_StepItem(
						icon: Icons.hourglass_empty,
						iconColor: _cPrimary,
						text: 'Processing & Analyzing trap image...',
						textColor: _cTextPrimary,
						isBold: true,
						isSpinning: true,
						spinController: _spinController,
					),
					_StepItem(
						icon: Icons.circle_outlined,
						iconColor: _cBorder,
						text: 'Analysis results queued',
						textColor: _cTextSecondary,
						isBold: false,
					),
				],
			),
		);
	}

	Widget _buildCancelButton() {
		return InkWell(
			onTap: () => context.pop(),
			child: const Text(
				'Cancel Upload',
				style: TextStyle(
					color: _cOrange,
					fontSize: 14,
					fontWeight: FontWeight.bold,
					decoration: TextDecoration.underline,
				),
			),
		);
	}
}

// ------------------------------------------------------------------
// Reusable Widgets
// ------------------------------------------------------------------

class _StepItem extends StatelessWidget {
	final IconData icon;
	final Color iconColor;
	final String text;
	final Color textColor;
	final bool isBold;
	final bool isSpinning;
	final AnimationController? spinController;

	const _StepItem({
		required this.icon,
		required this.iconColor,
		required this.text,
		required this.textColor,
		this.isBold = false,
		this.isSpinning = false,
		this.spinController,
	});

	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: const EdgeInsets.only(left: 20, bottom: 14),
			child: Row(
				children: [
					if (isSpinning && spinController != null)
						RotationTransition(
							turns: spinController!,
							child: Icon(icon, size: 20, color: iconColor),
						)
					else
						Icon(icon, size: 20, color: iconColor),
					const SizedBox(width: 12),
					Text(
						text,
						style: TextStyle(
							color: textColor,
							fontSize: 14,
							fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
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