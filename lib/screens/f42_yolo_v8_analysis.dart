import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import '../app_router.dart';

@Preview(name: 'F42YoloV8Analysis', size: Size(390.0, 844.0))
Widget previewF42YoloV8Analysis() {
	return const MaterialApp(
		debugShowCheckedModeBanner: false,
		home: F42Yolov8Analysis(observation: null),
	);
}

// ------------------------------------------------------------------
// Theme Constants
// ------------------------------------------------------------------
const Color _cBackground    = Color(0xFF0B0F19);
const Color _cSurface       = Color(0xE60B0F19);
const Color _cPrimary       = Color(0xFF10B981);
const Color _cDanger        = Color(0xFFE63946);
const Color _cWarning       = Color(0xFFE67E22);
const Color _cBorder        = Color(0x1AFFFFFF);
const Color _cTextPrimary   = Colors.white;
const Color _cTextSecondary = Color(0xFF5C6B5E);

const double _hPad = 24.0;

// ------------------------------------------------------------------
// F42Yolov8Analysis
// ------------------------------------------------------------------
class F42Yolov8Analysis extends StatefulWidget {
	final dynamic observation;
	const F42Yolov8Analysis({super.key, this.observation});

	@override
	F42Yolov8AnalysisState createState() => F42Yolov8AnalysisState();
}

class F42Yolov8AnalysisState extends State<F42Yolov8Analysis> {
	@override
	void initState() {
		super.initState();
		SystemChrome.setPreferredOrientations([
			DeviceOrientation.portraitUp,
			DeviceOrientation.portraitDown,
		]);

		Future.delayed(const Duration(seconds: 2), () {
			if (mounted) context.go(AppRouter.severityScore, extra: {'detection': 'dummy_data'});
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
							child: Center(
								child: _buildDetectionImage(),
							),
						),
						_buildDetectionCard(),
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
						'Detecting Pests',
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

	Widget _buildDetectionImage() {
		return AspectRatio(
			aspectRatio: 390 / 420,
			child: Stack(
				children: [
					// Base Image
					Positioned.fill(
						child: Image.network(
							"https://placehold.co/390x420",
							fit: BoxFit.cover,
						),
					),
					// Bounding Boxes
					_buildBoundingBox(60, 100, 45, 45, 'BPH 92%', _cDanger),
					_buildBoundingBox(160, 220, 80, 40, 'StemB 88%', _cWarning),
					_buildBoundingBox(240, 130, 50, 50, 'GLH 96%', _cPrimary),
					_buildBoundingBox(120, 80, 45, 35, 'BPH 85%', _cDanger),
				],
			),
		);
	}

	Widget _buildBoundingBox(double left, double top, double w, double h, String label, Color color) {
		return Positioned(
			left: left,
			top: top,
			child: Container(
				width: w,
				height: h,
				decoration: BoxDecoration(
					border: Border.all(width: 2, color: color),
					borderRadius: BorderRadius.circular(4),
				),
				child: Align(
					alignment: Alignment.topLeft,
					child: Container(
						padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
						decoration: BoxDecoration(
							color: color,
							borderRadius: const BorderRadius.only(bottomRight: Radius.circular(4)),
						),
						child: Text(
							label,
							style: const TextStyle(
								color: Colors.white,
								fontSize: 8,
								fontFamily: 'DM Sans',
								fontWeight: FontWeight.w700,
							),
						),
					),
				),
			),
		);
	}

	Widget _buildDetectionCard() {
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
								'STEP 2 OF 4',
								style: TextStyle(
									color: _cPrimary,
									fontSize: 12,
									fontFamily: 'DM Sans',
									fontWeight: FontWeight.w700,
								),
							),
							SizedBox(height: 4),
							Text(
								'YOLOv8 Detection',
								style: TextStyle(
									color: _cTextPrimary,
									fontSize: 18,
									fontFamily: 'Bricolage Grotesque',
									fontWeight: FontWeight.w700,
								),
							),
						],
					),
					// Status Badge
					Container(
						padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
						decoration: BoxDecoration(
							color: const Color(0x1AFFFFFF),
							borderRadius: BorderRadius.circular(100),
						),
						child: Row(
							mainAxisSize: MainAxisSize.min,
							spacing: 12,
							children: const [
								Text(
									'38 pests detected so far...',
									style: TextStyle(
										color: _cTextPrimary,
										fontSize: 13,
										fontFamily: 'DM Sans',
										fontWeight: FontWeight.w600,
									),
								),
								Text(
									'Min Confidence: 85%',
									style: TextStyle(
										color: _cPrimary,
										fontSize: 11,
										fontFamily: 'DM Sans',
										fontWeight: FontWeight.w600,
									),
								),
							],
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
							widthFactor: 0.6,
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