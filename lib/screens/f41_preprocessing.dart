import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import '../app_router.dart';

@Preview(name: 'F41Preprocessing', size: Size(390.0, 844.0))
Widget previewF41Preprocessing() {
	return const MaterialApp(
		debugShowCheckedModeBanner: false,
		home: F41Preprocessing(observation: null),
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

// Dark variant (used by this screen and other AI-processing steps)
const Color _cDarkBg        = Color(0xFF0E1B14);
const Color _cDarkSurface   = Color(0xFF16261D);
const Color _cDarkBorder    = Color(0xFF243B2D);
const Color _cAccentGreen   = Color(0xFF34D399);
const Color _cTextOnDark    = Color(0xFFFFFFFF);
const Color _cTextOnDarkMuted = Color(0xFF8FA396);

const double _hPad = 24.0;

// ------------------------------------------------------------------
// F41Preprocessing
// ------------------------------------------------------------------
class F41Preprocessing extends StatefulWidget {
	final dynamic observation;
	const F41Preprocessing({super.key, this.observation});

	@override
	F41PreprocessingState createState() => F41PreprocessingState();
}

class F41PreprocessingState extends State<F41Preprocessing>
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
			if (mounted) context.go(AppRouter.yoloAnalysis, extra: widget.observation);
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
			backgroundColor: _cDarkBg,
			body: SafeArea(
				child: Column(
					children: [
						Padding(
							padding: const EdgeInsets.symmetric(horizontal: _hPad),
							child: Column(
								children: [
									const SizedBox(height: 12),
									_buildHeader(),
									const SizedBox(height: 20),
								],
							),
						),
						Expanded(child: _buildImageArea()),
						_buildStepCard(),
					],
				),
			),
		);
	}

	Widget _buildHeader() {
		return Row(
			children: [
				InkWell(
					onTap: () => context.pop(),
					child: Container(
						width: 36,
						height: 36,
						alignment: Alignment.center,
						decoration: BoxDecoration(
							color: _cDarkSurface,
							shape: BoxShape.circle,
						),
						child: const Icon(Icons.chevron_left, color: _cTextOnDark, size: 22),
					),
				),
				const SizedBox(width: 14),
				const Text(
					'Processing Image',
					style: TextStyle(
						color: _cTextOnDark,
						fontSize: 20,
						fontWeight: FontWeight.bold,
					),
				),
			],
		);
	}

	Widget _buildImageArea() {
		return ClipRect(
			child: Stack(
				fit: StackFit.expand,
				children: [
					Image.network(
						'https://images.unsplash.com/photo-1592982537447-6f2a6a0c8b3e',
						fit: BoxFit.cover,
						errorBuilder: (context, error, stackTrace) => Container(
							color: _cPrimary,
						),
					),
					Center(
						child: Container(height: 2, color: _cAccentGreen.withValues(alpha: 0.85)),
					),
					const Positioned(top: 12, left: 12, child: _CornerBracket(corner: _Corner.topLeft)),
					const Positioned(top: 12, right: 12, child: _CornerBracket(corner: _Corner.topRight)),
					const Positioned(bottom: 12, left: 12, child: _CornerBracket(corner: _Corner.bottomLeft)),
					const Positioned(bottom: 12, right: 12, child: _CornerBracket(corner: _Corner.bottomRight)),
				],
			),
		);
	}

	Widget _buildStepCard() {
		return Container(
			width: double.infinity,
			padding: const EdgeInsets.fromLTRB(_hPad, 24, _hPad, 28),
			decoration: const BoxDecoration(
				color: _cDarkSurface,
				borderRadius: BorderRadius.only(
					topLeft: Radius.circular(28),
					topRight: Radius.circular(28),
				),
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					const Center(
						child: Text(
							'STEP 1 OF 4',
							style: TextStyle(
								color: _cAccentGreen,
								fontSize: 12,
								fontWeight: FontWeight.bold,
								letterSpacing: 0.5,
							),
						),
					),
					const SizedBox(height: 6),
					const Center(
						child: Text(
							'Noise Reduction',
							style: TextStyle(
								color: _cTextOnDark,
								fontSize: 18,
								fontWeight: FontWeight.bold,
							),
						),
					),
					const SizedBox(height: 18),
					Row(
						children: [
							RotationTransition(
								turns: _spinController,
								child: const Icon(Icons.autorenew, size: 18, color: _cAccentGreen),
							),
							const SizedBox(width: 10),
							const Expanded(
								child: Text(
									'Applying OpenCV noise reduction filters...',
									style: TextStyle(
										color: _cTextOnDark,
										fontSize: 14,
										fontWeight: FontWeight.w600,
									),
								),
							),
						],
					),
					const SizedBox(height: 14),
					ClipRRect(
						borderRadius: BorderRadius.circular(100),
						child: LinearProgressIndicator(
							value: 0.35,
							minHeight: 6,
							backgroundColor: _cDarkBorder,
							valueColor: const AlwaysStoppedAnimation<Color>(_cAccentGreen),
						),
					),
					const SizedBox(height: 10),
					const Text(
						'This may take a few seconds',
						style: TextStyle(
							color: _cTextOnDarkMuted,
							fontSize: 12,
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

enum _Corner { topLeft, topRight, bottomLeft, bottomRight }

class _CornerBracket extends StatelessWidget {
	final _Corner corner;
	const _CornerBracket({required this.corner});

	@override
	Widget build(BuildContext context) {
		final bool isTop = corner == _Corner.topLeft || corner == _Corner.topRight;
		final bool isLeft = corner == _Corner.topLeft || corner == _Corner.bottomLeft;

		return SizedBox(
			width: 22,
			height: 22,
			child: CustomPaint(
				painter: _BracketPainter(isTop: isTop, isLeft: isLeft),
			),
		);
	}
}

class _BracketPainter extends CustomPainter {
	final bool isTop;
	final bool isLeft;
	_BracketPainter({required this.isTop, required this.isLeft});

	@override
	void paint(Canvas canvas, Size size) {
		final paint = Paint()
			..color = _cAccentGreen
			..strokeWidth = 3
			..style = PaintingStyle.stroke
			..strokeCap = StrokeCap.round;

		final double x = isLeft ? 0 : size.width;
		final double y = isTop ? 0 : size.height;
		final Offset corner = Offset(x, y);

		// Vertical arm
		canvas.drawLine(corner, Offset(x, isTop ? size.height : 0), paint);
		// Horizontal arm
		canvas.drawLine(corner, Offset(isLeft ? size.width : 0, y), paint);
	}

	@override
	bool shouldRepaint(covariant _BracketPainter oldDelegate) => false;
}