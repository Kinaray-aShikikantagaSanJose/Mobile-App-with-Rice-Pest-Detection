import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import '../app_router.dart';

@Preview(name: 'F43SeverityScore', size: Size(390.0, 844.0))
Widget previewF43SeverityScore() {
	return const MaterialApp(
		debugShowCheckedModeBanner: false,
		home: F43SeverityScore(detection: null),
	);
}

// ------------------------------------------------------------------
// Theme Constants
// ------------------------------------------------------------------
const Color _cBackground    = Color(0xFF0B0F19);
const Color _cSurface       = Color(0xE60B0F19);
const Color _cPrimary       = Color(0xFF10B981);
const Color _cDanger        = Color(0xFFE63946);
const Color _cBorder        = Color(0x1AFFFFFF);
const Color _cTextPrimary   = Colors.white;
const Color _cTextSecondary = Color(0xFF5C6B5E);

const double _hPad = 24.0;

// Severity gauge scale (visual only — ring shows how far toward this
// ceiling the current pests/m² reading sits; not exposed to the user).
const double _severityGaugeMax = 20.0;

// ------------------------------------------------------------------
// F43SeverityScore
// ------------------------------------------------------------------
class F43SeverityScore extends StatefulWidget {
	final dynamic detection;
	const F43SeverityScore({super.key, this.detection});

	@override
	F43SeverityScoreState createState() => F43SeverityScoreState();
}

class F43SeverityScoreState extends State<F43SeverityScore> {
	@override
	void initState() {
		super.initState();
		SystemChrome.setPreferredOrientations([
			DeviceOrientation.portraitUp,
			DeviceOrientation.portraitDown,
		]);

		Future.delayed(const Duration(seconds: 2), () {
			if (mounted) context.go(AppRouter.resultsSummary, extra: widget.detection);
		});
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: _cBackground,
			body: SafeArea(
				child: Column(
					children: [
						Padding(
							padding: const EdgeInsets.symmetric(horizontal: _hPad, vertical: 8),
							child: _buildHeader(),
						),
						Expanded(
							child: SingleChildScrollView(
								child: Column(
									children: [
										const SizedBox(height: 40),
										_buildSeverityIndicator(),
										const SizedBox(height: 40),
									],
								),
							),
						),
						_buildAssessmentCard(),
						const SizedBox(height: 16),
						const _HomeIndicator(),
						const SizedBox(height: 8),
					],
				),
			),
		);
	}

	Widget _buildHeader() {
		return Row(
			children: [
				_BackButton(onTap: () => context.pop()),
				const SizedBox(width: 16),
				const Expanded(
					child: Text(
						'Calculating Severity',
						style: TextStyle(
							color: _cTextPrimary,
							fontSize: 20,
							fontFamily: 'Bricolage Grotesque',
							fontWeight: FontWeight.w700,
						),
					),
				),
			],
		);
	}

	Widget _buildSeverityIndicator() {
		const double pestsPerSqm = 16.8;
		const double fraction = pestsPerSqm / _severityGaugeMax;

		return Column(
			mainAxisSize: MainAxisSize.min,
			children: [
				SizedBox(
					width: 200,
					height: 200,
					child: Stack(
						children: [
							// Background ring
							Positioned.fill(
								child: Container(
									decoration: const ShapeDecoration(
										shape: OvalBorder(
											side: BorderSide(width: 16, color: _cBorder),
										),
									),
								),
							),
							// Active progress arc (partial, proportional to fraction)
							Positioned.fill(
								child: CustomPaint(
									painter: _ArcPainter(
										fraction: fraction,
										color: _cDanger,
										strokeWidth: 16,
									),
								),
							),
							// Center Text
							Positioned.fill(
								child: Column(
									mainAxisAlignment: MainAxisAlignment.center,
									children: [
										const Text(
											'16.8',
											style: TextStyle(
												color: _cTextPrimary,
												fontSize: 32,
												fontFamily: 'Bricolage Grotesque',
												fontWeight: FontWeight.w700,
											),
										),
										Opacity(
											opacity: 0.60,
											child: const Text(
												'pests/m²',
												style: TextStyle(
													color: _cTextPrimary,
													fontSize: 13,
													fontFamily: 'DM Sans',
													fontWeight: FontWeight.w500,
												),
											),
										),
									],
								),
							),
						],
					),
				),
				const SizedBox(height: 24),
				Container(
					padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
					decoration: BoxDecoration(
						color: _cDanger,
						borderRadius: BorderRadius.circular(100),
					),
					child: const Text(
						'HIGH SEVERITY',
						style: TextStyle(
							color: _cTextPrimary,
							fontSize: 13,
							fontFamily: 'DM Sans',
							fontWeight: FontWeight.w700,
						),
					),
				),
			],
		);
	}

	Widget _buildAssessmentCard() {
		return Container(
			width: double.infinity,
			padding: const EdgeInsets.fromLTRB(_hPad, 24, _hPad, 20),
			decoration: BoxDecoration(
				color: _cSurface,
				borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
				border: Border.all(color: _cBorder, width: 1),
			),
			child: Column(
				mainAxisSize: MainAxisSize.min,
				spacing: 20,
				children: [
					const Column(
						children: [
							Text(
								'STEP 3 OF 4',
								style: TextStyle(
									color: _cPrimary,
									fontSize: 12,
									fontFamily: 'DM Sans',
									fontWeight: FontWeight.w700,
								),
							),
							SizedBox(height: 4),
							Text(
								'Severity Assessment',
								style: TextStyle(
									color: _cTextPrimary,
									fontSize: 18,
									fontFamily: 'Bricolage Grotesque',
									fontWeight: FontWeight.w700,
								),
							),
						],
					),
					const Text(
						'Low: <5/m²  |  Medium: 5-15/m²  |  High: >15/m²',
						textAlign: TextAlign.center,
						style: TextStyle(
							color: _cTextSecondary,
							fontSize: 12,
							fontFamily: 'DM Sans',
							fontWeight: FontWeight.w400,
						),
					),
					// Progress Bar
					Container(
						width: double.infinity,
						height: 6,
						decoration: BoxDecoration(
							color: _cBorder,
							borderRadius: BorderRadius.circular(3),
						),
						child: FractionallySizedBox(
							alignment: Alignment.centerLeft,
							widthFactor: 0.8,
							child: Container(
								decoration: BoxDecoration(
									color: _cPrimary,
									borderRadius: BorderRadius.circular(3),
								),
							),
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
					color: const Color(0xCC121824),
					shape: BoxShape.circle,
					border: Border.all(color: _cBorder, width: 1),
				),
				child: const Icon(Icons.arrow_back, color: _cTextPrimary, size: 20),
			),
		);
	}
}

class _HomeIndicator extends StatelessWidget {
	const _HomeIndicator();

	@override
	Widget build(BuildContext context) {
		return const Center(
			child: Opacity(
				opacity: 0.4,
				child: SizedBox(
					width: 134,
					height: 5,
					child: DecoratedBox(
						decoration: BoxDecoration(
							color: _cTextPrimary,
							borderRadius: BorderRadius.all(Radius.circular(2.5)),
						),
					),
				),
			),
		);
	}
}

class _ArcPainter extends CustomPainter {
	final double fraction;
	final Color color;
	final double strokeWidth;

	_ArcPainter({
		required this.fraction,
		required this.color,
		required this.strokeWidth,
	});

	@override
	void paint(Canvas canvas, Size size) {
		final Rect rect = (Offset.zero & size).deflate(strokeWidth / 2);
		final Paint paint = Paint()
			..color = color
			..strokeWidth = strokeWidth
			..style = PaintingStyle.stroke
			..strokeCap = StrokeCap.round;

		const double startAngle = -pi / 2; // 12 o'clock
		final double sweepAngle = 2 * pi * fraction.clamp(0.0, 1.0);

		canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
	}

	@override
	bool shouldRepaint(covariant _ArcPainter oldDelegate) {
		return oldDelegate.fraction != fraction ||
				oldDelegate.color != color ||
				oldDelegate.strokeWidth != strokeWidth;
	}
}