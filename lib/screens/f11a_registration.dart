import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import '../app_router.dart';

@Preview(name: 'F11aRegistration', size: Size(390.0, 844.0))
Widget previewF11aRegistration() {
	return const MaterialApp(
		debugShowCheckedModeBanner: false,
		home: F11aRegistration(),
	);
}

class F11aRegistration extends StatefulWidget {
	const F11aRegistration({super.key});

	@override
	F11aRegistrationState createState() => F11aRegistrationState();
}

class F11aRegistrationState extends State<F11aRegistration> {
	bool _obscurePassword = true;
	bool _obscureConfirmPassword = true;
	bool _agreedToTerms = false;

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
			backgroundColor: const Color(0xFFFAF8F5),
			body: SafeArea(
				child: SizedBox.expand(
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							// Scrollable Content
							Expanded(
								child: SingleChildScrollView(
									padding: const EdgeInsets.symmetric(horizontal: 24),
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: [
											const SizedBox(height: 12),
											// Back Button
											InkWell(
												onTap: () => context.pop(),
												borderRadius: BorderRadius.circular(20),
												child: Container(
													width: 40,
													height: 40,
													decoration: BoxDecoration(
														color: const Color(0xFFFFFFFF),
														shape: BoxShape.circle,
														border: Border.all(
															color: const Color(0xFFE5E0D8),
															width: 1,
														),
													),
													child: const Icon(
														Icons.chevron_left,
														color: Color(0xFF1B4332),
														size: 24,
													),
												),
											),
											const SizedBox(height: 24),
											// Title
											const Text(
												"Create Account",
												style: TextStyle(
													color: Color(0xFF1B4332),
													fontSize: 28,
													fontWeight: FontWeight.bold,
												),
											),
											const SizedBox(height: 4),
											// Subtitle
											const Text(
												"Start protecting your crops with smart automated detection tools.",
												style: TextStyle(
													color: Color(0xFF5C6B5E),
													fontSize: 14,
													height: 1.4,
												),
											),
											const SizedBox(height: 24),
											// Full Name
											_FormField(
												label: "FULL NAME",
												hintText: "Juan Dela Cruz",
												icon: Icons.person_outline,
												keyboardType: TextInputType.name,
											),
											const SizedBox(height: 16),
											// Phone or Email
											_FormField(
												label: "PHONE NUMBER OR EMAIL",
												hintText: "farmer@domain.com or +63...",
												icon: Icons.mail_outline,
												keyboardType: TextInputType.emailAddress,
											),
											const SizedBox(height: 16),
											// Password
											_PasswordField(
												label: "PASSWORD",
												obscureText: _obscurePassword,
												onToggle: () {
													setState(() {
														_obscurePassword = !_obscurePassword;
													});
												},
											),
											const SizedBox(height: 16),
											// Confirm Password
											_PasswordField(
												label: "CONFIRM PASSWORD",
												obscureText: _obscureConfirmPassword,
												onToggle: () {
													setState(() {
														_obscureConfirmPassword = !_obscureConfirmPassword;
													});
												},
											),
											const SizedBox(height: 16),
											// Select Region
											_RegionDropdown(
												label: "SELECT REGION",
												value: "Central Luzon (Region III)",
											),
											const SizedBox(height: 16),
											// Terms Checkbox
											InkWell(
												onTap: () {
													setState(() {
														_agreedToTerms = !_agreedToTerms;
													});
												},
												child: Row(
													children: [
														SizedBox(
															width: 22,
															height: 22,
															child: Padding(
																padding: const EdgeInsets.only(right: 10),
																child: _agreedToTerms
																		? Container(
																	decoration: BoxDecoration(
																		color: const Color(0xFF2D6A4F),
																		borderRadius: BorderRadius.circular(6),
																	),
																	child: const Icon(
																		Icons.check,
																		size: 16,
																		color: Color(0xFFFFFFFF),
																	),
																)
																		: DecoratedBox(
																	decoration: BoxDecoration(
																		border: Border.all(
																			color: const Color(0xFFE5E0D8),
																			width: 1.5,
																		),
																		borderRadius: BorderRadius.circular(6),
																	),
																),
															),
														),
														Expanded(
															child: RichText(
																text: TextSpan(
																	style: const TextStyle(
																		color: Color(0xFF5C6B5E),
																		fontSize: 14,
																	),
																	children: [
																		const TextSpan(text: "I agree to "),
																		TextSpan(
																			text: "Terms",
																			style: const TextStyle(
																				color: Color(0xFF2D6A4F),
																				fontWeight: FontWeight.bold,
																				decoration: TextDecoration.underline,
																			),
																		),
																		const TextSpan(text: " & "),
																		TextSpan(
																			text: "Privacy Policy",
																			style: const TextStyle(
																				color: Color(0xFF2D6A4F),
																				fontWeight: FontWeight.bold,
																				decoration: TextDecoration.underline,
																			),
																		),
																	],
																),
															),
														),
													],
												),
											),
											const SizedBox(height: 24),
											// Register Button
											InkWell(
												onTap: () => context.push(AppRouter.otp, extra: 'dummy@example.com'),
												borderRadius: BorderRadius.circular(100),
												child: Container(
													width: double.infinity,
													padding: const EdgeInsets.symmetric(vertical: 18),
													decoration: BoxDecoration(
														color: const Color(0xFF2D6A4F),
														borderRadius: BorderRadius.circular(100),
													),
													child: const Text(
														"Register",
														style: TextStyle(
															color: Color(0xFFFFFFFF),
															fontSize: 15,
															fontWeight: FontWeight.bold,
														),
														textAlign: TextAlign.center,
													),
												),
											),
											const SizedBox(height: 16),
											// Already have account
											Row(
												mainAxisAlignment: MainAxisAlignment.center,
												children: [
													const Text(
														"Already have an account? ",
														style: TextStyle(
															color: Color(0xFF5C6B5E),
															fontSize: 14,
														),
													),
													InkWell(
														onTap: () => context.go(AppRouter.login),
														child: const Text(
															"Log In",
															style: TextStyle(
																color: Color(0xFF2D6A4F),
																fontSize: 14,
																fontWeight: FontWeight.bold,
																decoration: TextDecoration.underline,
															),
														),
													),
												],
											),
											const SizedBox(height: 24),
											// Home Indicator
											const Center(
												child: SizedBox(
													width: 134,
													height: 5,
													child: DecoratedBox(
														decoration: BoxDecoration(
															color: Color(0xFF1B4332),
															borderRadius: BorderRadius.all(Radius.circular(100)),
														),
													),
												),
											),
											const SizedBox(height: 16),
										],
									),
								),
							),
						],
					),
				),
			),
		);
	}
}

class _FormField extends StatelessWidget {
	final String label;
	final String hintText;
	final IconData icon;
	final TextInputType keyboardType;

	const _FormField({
		required this.label,
		required this.hintText,
		required this.icon,
		this.keyboardType = TextInputType.text,
	});

	@override
	Widget build(BuildContext context) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				Text(
					label,
					style: const TextStyle(
						color: Color(0xFF1B4332),
						fontSize: 12,
						fontWeight: FontWeight.bold,
					),
				),
				const SizedBox(height: 8),
				Container(
					decoration: BoxDecoration(
						color: const Color(0xFFFFFFFF),
						borderRadius: BorderRadius.circular(100),
						border: Border.all(
							color: const Color(0xFFE5E0D8),
							width: 1,
						),
					),
					padding: const EdgeInsets.symmetric(horizontal: 18),
					child: Row(
						children: [
							Padding(
								padding: const EdgeInsets.only(right: 12),
								child: Icon(icon, size: 20, color: const Color(0xFF8E9E90)),
							),
							Expanded(
								child: TextField(
									keyboardType: keyboardType,
									style: const TextStyle(
										color: Color(0xFF1B4332),
										fontSize: 14,
									),
									decoration: InputDecoration(
										hintText: hintText,
										hintStyle: const TextStyle(
											color: Color(0xFF8E9E90),
											fontSize: 14,
										),
										isDense: true,
										contentPadding: const EdgeInsets.symmetric(vertical: 18),
										border: InputBorder.none,
										focusedBorder: InputBorder.none,
										filled: false,
									),
								),
							),
						],
					),
				),
			],
		);
	}
}

class _PasswordField extends StatelessWidget {
	final String label;
	final bool obscureText;
	final VoidCallback onToggle;

	const _PasswordField({
		required this.label,
		required this.obscureText,
		required this.onToggle,
	});

	@override
	Widget build(BuildContext context) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				Text(
					label,
					style: const TextStyle(
						color: Color(0xFF1B4332),
						fontSize: 12,
						fontWeight: FontWeight.bold,
					),
				),
				const SizedBox(height: 8),
				Container(
					decoration: BoxDecoration(
						color: const Color(0xFFFFFFFF),
						borderRadius: BorderRadius.circular(100),
						border: Border.all(
							color: const Color(0xFFE5E0D8),
							width: 1,
						),
					),
					padding: const EdgeInsets.symmetric(horizontal: 18),
					child: Row(
						children: [
							const Padding(
								padding: EdgeInsets.only(right: 12),
								child: Icon(Icons.lock_outline, size: 20, color: Color(0xFF8E9E90)),
							),
							Expanded(
								child: TextField(
									obscureText: obscureText,
									style: const TextStyle(
										color: Color(0xFF1B4332),
										fontSize: 14,
									),
									decoration: const InputDecoration(
										hintText: "••••••••••••••",
										hintStyle: TextStyle(
											color: Color(0xFF1B4332),
											fontSize: 14,
										),
										isDense: true,
										contentPadding: EdgeInsets.symmetric(vertical: 18),
										border: InputBorder.none,
										focusedBorder: InputBorder.none,
										filled: false,
									),
								),
							),
							InkWell(
								onTap: onToggle,
								borderRadius: BorderRadius.circular(100),
								child: Icon(
									obscureText ? Icons.visibility : Icons.visibility_off,
									size: 20,
									color: const Color(0xFF8E9E90),
								),
							),
						],
					),
				),
			],
		);
	}
}

class _RegionDropdown extends StatelessWidget {
	final String label;
	final String value;

	const _RegionDropdown({
		required this.label,
		required this.value,
	});

	@override
	Widget build(BuildContext context) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				Text(
					label,
					style: const TextStyle(
						color: Color(0xFF1B4332),
						fontSize: 12,
						fontWeight: FontWeight.bold,
					),
				),
				const SizedBox(height: 8),
				InkWell(
					onTap: () => debugPrint('Pressed Region'),
					borderRadius: BorderRadius.circular(100),
					child: Container(
						decoration: BoxDecoration(
							color: const Color(0xFFFFFFFF),
							borderRadius: BorderRadius.circular(100),
							border: Border.all(
								color: const Color(0xFFE5E0D8),
								width: 1,
							),
						),
						padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
						child: Row(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							children: [
								Row(
									children: [
										const Padding(
											padding: EdgeInsets.only(right: 12),
											child: Icon(Icons.location_on_outlined, size: 20, color: Color(0xFF8E9E90)),
										),
										Text(
											value,
											style: const TextStyle(
												color: Color(0xFF1B4332),
												fontSize: 14,
											),
										),
									],
								),
								const Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF8E9E90)),
							],
						),
					),
				),
			],
		);
	}
}