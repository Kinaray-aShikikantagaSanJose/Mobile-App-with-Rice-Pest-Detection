import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import '../app_router.dart';
import '../services/auth_service.dart';

@Preview(name: 'F10SplashWelcome', size: Size(390.0, 844.0))
Widget previewF10SplashWelcome() {
	return const MaterialApp(
		debugShowCheckedModeBanner: false,
		home: F10SplashWelcome(skipSessionCheck: true),
	);
}

class F10SplashWelcome extends StatefulWidget {
	final bool skipSessionCheck;
	const F10SplashWelcome({super.key, this.skipSessionCheck = false});

	@override
	F10SplashWelcomeState createState() => F10SplashWelcomeState();
}

class F10SplashWelcomeState extends State<F10SplashWelcome> {
	@override
	void initState() {
		super.initState();
		SystemChrome.setPreferredOrientations([
			DeviceOrientation.portraitUp,
			DeviceOrientation.portraitDown,
		]);
		if (!widget.skipSessionCheck) {
			_checkExistingSession();
		}
	}

	// Skips the splash/login options entirely if a session is already stored.
	Future<void> _checkExistingSession() async {
		final bool loggedIn = await AuthService.instance.isLoggedIn();
		if (loggedIn && mounted) context.go(AppRouter.home);
	}

	@override
	void dispose() {
		SystemChrome.setPreferredOrientations([
			DeviceOrientation.portraitUp,
			DeviceOrientation.portraitDown,
			DeviceOrientation.landscapeLeft,
			DeviceOrientation.landscapeRight,
		]);
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Container(
				width: double.infinity,
				height: double.infinity,
				decoration: const BoxDecoration(
					color: Color(0xFF1B4332),
					image: DecorationImage(
						image: NetworkImage(
							"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/yQk73Zdz3g/f11umvpm_expires_30_days.png",
						),
						fit: BoxFit.cover,
					),
				),
				child: SafeArea(
					child: SingleChildScrollView(
						child: ConstrainedBox(
							constraints: BoxConstraints(
								minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
							),
							child: IntrinsicHeight(
								child: Column(
									children: [
										// Main Content
										Expanded(
											child: Padding(
												padding: const EdgeInsets.symmetric(horizontal: 24),
												child: Column(
													mainAxisAlignment: MainAxisAlignment.center,
													children: [
														const Spacer(flex: 2),
														// App Icon
														Container(
															width: 100,
															height: 100,
															decoration: BoxDecoration(
																color: const Color(0xFFD8F3DC),
																borderRadius: BorderRadius.circular(32),
															),
															child: ClipRRect(
																borderRadius: BorderRadius.circular(32),
																child: Image.network(
																	"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/yQk73Zdz3g/1g2cyw0d_expires_30_days.png",
																	fit: BoxFit.cover,
																),
															),
														),
														const SizedBox(height: 24),
														// Title
														const Text(
															"Rice Pest Infestation Detector",
															style: TextStyle(
																color: Color(0xFFFFFFFF),
																fontSize: 32,
																fontWeight: FontWeight.bold,
																height: 1.2,
															),
															textAlign: TextAlign.center,
														),
														const SizedBox(height: 8),
														// Subtitle
														const Text(
															"Smart Field Protection for Modern Farmers",
															style: TextStyle(
																color: Color(0xFFD8F3DC),
																fontSize: 15,
															),
															textAlign: TextAlign.center,
														),
														const Spacer(flex: 3),
													],
												),
											),
										),
										// Bottom Buttons
										Padding(
											padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
											child: Column(
												children: [
													_ActionButton(
														label: "Log In",
														backgroundColor: const Color(0xFF2D6A4F),
														textColor: const Color(0xFFFFFFFF),
														onTap: () => context.go(AppRouter.login),
													),
													const SizedBox(height: 16),
													_ActionButton(
														label: "Create Account",
														backgroundColor: const Color(0x1AFFFFFF),
														textColor: const Color(0xFFFFFFFF),
														borderColor: const Color(0x1AFFFFFF),
														onTap: () => context.go(AppRouter.register),
													),
													const SizedBox(height: 16),
													// Home Indicator
													const SizedBox(
														width: 134,
														height: 5,
														child: DecoratedBox(
															decoration: BoxDecoration(
																color: Color(0xFFFFFFFF),
																borderRadius: BorderRadius.all(Radius.circular(100)),
															),
														),
													),
												],
											),
										),
									],
								),
							),
						),
					),
				),
			),
		);
	}
}

class _ActionButton extends StatelessWidget {
	final String label;
	final Color backgroundColor;
	final Color textColor;
	final Color? borderColor;
	final VoidCallback onTap;

	const _ActionButton({
		required this.label,
		required this.backgroundColor,
		required this.textColor,
		this.borderColor,
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
					color: backgroundColor,
					borderRadius: BorderRadius.circular(100),
					border: borderColor != null
							? Border.all(color: borderColor!, width: 1)
							: null,
				),
				child: Text(
					label,
					style: TextStyle(
						color: textColor,
						fontSize: 15,
						fontWeight: FontWeight.bold,
					),
					textAlign: TextAlign.center,
				),
			),
		);
	}
}