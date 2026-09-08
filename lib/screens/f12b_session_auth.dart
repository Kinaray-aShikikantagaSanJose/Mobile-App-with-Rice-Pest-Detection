import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import '../app_router.dart';

@Preview(name: 'F12bSessionAuth', size: Size(390.0, 844.0))
Widget previewF12bSessionAuth() {
	return const MaterialApp(
		debugShowCheckedModeBanner: false,
		home: F12bSessionAuth(),
	);
}

// ------------------------------------------------------------------
// Theme Constants
// ------------------------------------------------------------------
const Color _cPrimaryDark = Color(0xFF1B4332);
const Color _cAccentLight = Color(0xFFD8F3DC);
const Color _cSurface     = Color(0xFFFFFFFF);

// ------------------------------------------------------------------
// F12bSessionAuth
// ------------------------------------------------------------------
class F12bSessionAuth extends StatefulWidget {
	const F12bSessionAuth({super.key});

	@override
	F12bSessionAuthState createState() => F12bSessionAuthState();
}

class F12bSessionAuthState extends State<F12bSessionAuth>
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
			if (mounted) context.go(AppRouter.home);
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
			backgroundColor: _cPrimaryDark,
			body: SafeArea(
				child: Column(
					children: [
						const SizedBox(height: 12),
						Expanded(
							child: Center(
								child: Column(
									mainAxisSize: MainAxisSize.min,
									children: [
										_buildSpinner(),
										const SizedBox(height: 40),
										const Text(
											'Authenticating your session...',
											style: TextStyle(
												color: _cSurface,
												fontSize: 22,
												fontWeight: FontWeight.bold,
												height: 1.3,
											),
										),
										const SizedBox(height: 12),
										Row(
											mainAxisSize: MainAxisSize.min,
											children: [
												const Icon(
													Icons.lock_outline,
													size: 16,
													color: _cAccentLight,
												),
												const SizedBox(width: 8),
												Text(
													'Securing your data with end-to-end encryption',
													style: TextStyle(
														color: _cAccentLight,
														fontSize: 14,
														height: 1.4,
													),
												),
											],
										),
									],
								),
							),
						),
						const _HomeIndicator(),
						const SizedBox(height: 8),
					],
				),
			),
		);
	}

	Widget _buildSpinner() {
		return SizedBox(
			width: 100,
			height: 100,
			child: Stack(
				alignment: Alignment.center,
				children: [
					RotationTransition(
						turns: _spinController,
						child: SizedBox(
							width: 100,
							height: 100,
							child: CircularProgressIndicator(
								strokeWidth: 3,
								value: 0.35,
								backgroundColor: _cAccentLight.withValues(alpha: 0.2),
								valueColor: const AlwaysStoppedAnimation<Color>(_cAccentLight),
							),
						),
					),
					Container(
						width: 72,
						height: 72,
						decoration: BoxDecoration(
							color: _cAccentLight.withValues(alpha: 0.15),
							shape: BoxShape.circle,
						),
						child: const Icon(
							Icons.eco_outlined,
							size: 32,
							color: _cAccentLight,
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
						color: _cSurface,
						borderRadius: BorderRadius.all(Radius.circular(100)),
					),
				),
			),
		);
	}
}