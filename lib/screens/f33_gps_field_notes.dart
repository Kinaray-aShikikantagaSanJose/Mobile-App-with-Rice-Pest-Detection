import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import '../app_router.dart';

@Preview(name: 'F33GpsFieldNotes', size: Size(390.0, 844.0))
Widget previewF33GpsFieldNotes() {
	return const MaterialApp(
		debugShowCheckedModeBanner: false,
		home: F33GpsFieldNotes(imagePath: 'dummy_path.jpg'),
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

const double _hPad = 24.0;

// ------------------------------------------------------------------
// F33GpsFieldNotes
// ------------------------------------------------------------------
class F33GpsFieldNotes extends StatefulWidget {
	final String imagePath;
	const F33GpsFieldNotes({super.key, required this.imagePath});

	@override
	F33GpsFieldNotesState createState() => F33GpsFieldNotesState();
}

class F33GpsFieldNotesState extends State<F33GpsFieldNotes> {
	final TextEditingController _notesController = TextEditingController();

	@override
	void initState() {
		super.initState();
		SystemChrome.setPreferredOrientations([
			DeviceOrientation.portraitUp,
			DeviceOrientation.portraitDown,
		]);
	}

	@override
	void dispose() {
		_notesController.dispose();
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
										const SizedBox(height: 16),
										_buildMapCard(),
										const SizedBox(height: 16),
										_buildFieldInfoCard(),
										const SizedBox(height: 16),
										_buildNotesField(),
										const SizedBox(height: 16),
										_buildAttachButton(),
										const SizedBox(height: 100),
									],
								),
							),
						),
						Padding(
							padding: const EdgeInsets.fromLTRB(_hPad, 12, _hPad, 0),
							child: _PrimaryButton(
								label: 'Submit Scan',
								onTap: () => context.go(AppRouter.onlineRouter, extra: {'image': widget.imagePath, 'notes': _notesController.text}),
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

	Widget _buildHeader() {
		return Row(
			children: [
				_BackButton(onTap: () => context.pop()),
				const SizedBox(width: 12),
				const Text(
					'Location & Notes',
					style: TextStyle(
						color: _cTextPrimary,
						fontSize: 20,
						fontWeight: FontWeight.bold,
					),
				),
			],
		);
	}

	Widget _buildMapCard() {
		return Container(
			padding: const EdgeInsets.all(12),
			decoration: BoxDecoration(
				color: _cSurface,
				borderRadius: BorderRadius.circular(24),
				border: Border.all(color: _cBorder, width: 1),
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					ClipRRect(
						borderRadius: BorderRadius.circular(16),
						child: Container(
							height: 160,
							width: double.infinity,
							color: const Color(0xFFE8E4DC),
							child: Stack(
								alignment: Alignment.center,
								children: [
									// Satellite map placeholder pattern
									Container(
										decoration: BoxDecoration(
											gradient: LinearGradient(
												begin: Alignment.topLeft,
												end: Alignment.bottomRight,
												colors: [
													const Color(0xFFD4CFC5),
													const Color(0xFFC8C2B6),
													const Color(0xFFB5AEA0),
												],
											),
										),
									),
									// Grid pattern overlay
									CustomPaint(
										size: const Size(double.infinity, 160),
										painter: _MapGridPainter(),
									),
									// Pin
									const Icon(
										Icons.location_on,
										size: 36,
										color: Color(0xFFE74C3C),
									),
								],
							),
						),
					),
					const SizedBox(height: 12),
					Row(
						children: [
							const Icon(
								Icons.location_on_outlined,
								size: 18,
								color: _cPrimary,
							),
							const SizedBox(width: 8),
							const Text(
								'14.5995° N, 120.9842° E',
								style: TextStyle(
									color: _cTextPrimary,
									fontSize: 14,
									fontWeight: FontWeight.bold,
								),
							),
						],
					),
				],
			),
		);
	}

	Widget _buildFieldInfoCard() {
		return Container(
			padding: const EdgeInsets.all(16),
			decoration: BoxDecoration(
				color: _cSurface,
				borderRadius: BorderRadius.circular(20),
				border: Border.all(color: _cBorder, width: 1),
			),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children: [
					Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							const Text(
								'FIELD',
								style: TextStyle(
									color: _cTextSecondary,
									fontSize: 11,
									fontWeight: FontWeight.bold,
								),
							),
							const SizedBox(height: 4),
							const Text(
								'Field Block A-1',
								style: TextStyle(
									color: _cTextPrimary,
									fontSize: 14,
									fontWeight: FontWeight.bold,
								),
							),
						],
					),
					Column(
						crossAxisAlignment: CrossAxisAlignment.end,
						children: [
							const Text(
								'TIMESTAMP',
								style: TextStyle(
									color: _cTextSecondary,
									fontSize: 11,
									fontWeight: FontWeight.bold,
								),
							),
							const SizedBox(height: 4),
							const Text(
								'Aug 16, 2026 • 10:32 AM',
								style: TextStyle(
									color: _cTextPrimary,
									fontSize: 14,
									fontWeight: FontWeight.bold,
								),
							),
						],
					),
				],
			),
		);
	}

	Widget _buildNotesField() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					'FIELD NOTES',
					style: TextStyle(
						color: _cTextPrimary,
						fontSize: 12,
						fontWeight: FontWeight.bold,
					),
				),
				const SizedBox(height: 8),
				Container(
					height: 120,
					decoration: BoxDecoration(
						color: _cSurface,
						borderRadius: BorderRadius.circular(16),
						border: Border.all(color: _cBorder, width: 1),
					),
					child: TextField(
						controller: _notesController,
						maxLines: null,
						expands: true,
						textAlignVertical: TextAlignVertical.top,
						style: const TextStyle(
							color: _cTextPrimary,
							fontSize: 14,
						),
						decoration: InputDecoration(
							hintText: 'Add observations about field conditions...',
							hintStyle: TextStyle(
								color: _cTextMuted,
								fontSize: 14,
							),
							border: InputBorder.none,
							contentPadding: const EdgeInsets.all(16),
						),
					),
				),
			],
		);
	}

	Widget _buildAttachButton() {
		return InkWell(
			onTap: () => debugPrint('Attach photos pressed'),
			borderRadius: BorderRadius.circular(100),
			child: Container(
				padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
				decoration: BoxDecoration(
					color: _cSurface,
					borderRadius: BorderRadius.circular(100),
					border: Border.all(color: _cBorder, width: 1),
				),
				child: Row(
				mainAxisSize: MainAxisSize.min,
					children: [
						const Icon(Icons.add, size: 16, color: _cTextPrimary),
						const SizedBox(width: 8),
						const Text(
							'Attach Additional Photos',
							style: TextStyle(
								color: _cTextPrimary,
								fontSize: 14,
								fontWeight: FontWeight.bold,
							),
						),
					],
				),
			),
		);
	}
}

// ------------------------------------------------------------------
// Map Grid Painter
// ------------------------------------------------------------------
class _MapGridPainter extends CustomPainter {
	@override
	void paint(Canvas canvas, Size size) {
		final paint = Paint()
			..color = const Color(0xFF8B7D6B).withValues(alpha: 0.15)
			..strokeWidth = 0.5;

		const spacing = 20.0;
		for (double x = 0; x < size.width; x += spacing) {
			canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
		}
		for (double y = 0; y < size.height; y += spacing) {
			canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
		}

		// Add some random "field" patches
		final patchPaint = Paint()
			..color = const Color(0xFF7A9E5C).withValues(alpha: 0.25);
		canvas.drawRect(const Rect.fromLTWH(40, 30, 60, 40), patchPaint);
		canvas.drawRect(const Rect.fromLTWH(120, 80, 80, 50), patchPaint);
		canvas.drawRect(const Rect.fromLTWH(220, 20, 50, 60), patchPaint);
		canvas.drawRect(const Rect.fromLTWH(180, 110, 70, 30), patchPaint);
	}

	@override
	bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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