import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import '../app_router.dart';

@Preview(name: 'F11bOtpVerification', size: Size(390.0, 844.0))
Widget previewF11bOtpVerification() {
	return const MaterialApp(
		debugShowCheckedModeBanner: false,
		home: F11bOtpVerification(contact: 'farmer@example.com'),
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
const Color _cOrangeLight   = Color(0xFFFDF2E9);

const double _hPad = 24.0;

// ------------------------------------------------------------------
// F11bOtpVerification
// ------------------------------------------------------------------
class F11bOtpVerification extends StatefulWidget {
	final String contact;
	const F11bOtpVerification({super.key, required this.contact});

	@override
	F11bOtpVerificationState createState() => F11bOtpVerificationState();
}

class F11bOtpVerificationState extends State<F11bOtpVerification> {
	final List<TextEditingController> _controllers =
	List.generate(6, (_) => TextEditingController());
	final List<FocusNode> _focusNodes =
	List.generate(6, (_) => FocusNode());
	int _activeIndex = 3;

	@override
	void initState() {
		super.initState();
		SystemChrome.setPreferredOrientations([
			DeviceOrientation.portraitUp,
			DeviceOrientation.portraitDown,
		]);
		// Pre-fill to match screenshot state
		_controllers[0].text = '8';
		_controllers[1].text = '4';
		_controllers[2].text = '2';
		WidgetsBinding.instance.addPostFrameCallback((_) {
			if (mounted) FocusScope.of(context).requestFocus(_focusNodes[3]);
		});
	}

	@override
	void dispose() {
		for (final c in _controllers) c.dispose();
		for (final f in _focusNodes) f.dispose();
		super.dispose();
	}

	void _onOtpChanged(int index, String value) {
		if (value.isNotEmpty && index < 5) {
			FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
			setState(() => _activeIndex = index + 1);
		}
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
										_BackButton(onTap: () => context.pop()),
										const SizedBox(height: 8),
										_buildHeader(),
										const SizedBox(height: 24),
										_buildShieldIcon(),
										const SizedBox(height: 12),
										_buildOtpRow(),
										const SizedBox(height: 12),
										_buildResendRow(),
									],
								),
							),
						),
						Padding(
							padding: const EdgeInsets.fromLTRB(_hPad, 12, _hPad, 0),
							child: _PrimaryButton(
								label: 'Verify',
								onTap: () => context.go(AppRouter.login),
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
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					'Verify Your Account',
					style: TextStyle(
						color: _cTextPrimary,
						fontSize: 28,
						fontWeight: FontWeight.bold,
						height: 1.2,
					),
				),
				const SizedBox(height: 4),
				Text(
					'Enter the 6-digit code sent to ${widget.contact} to continue.',
					style: TextStyle(
						color: _cTextSecondary,
						fontSize: 14,
						height: 1.4,
					),
				),
			],
		);
	}

	Widget _buildShieldIcon() {
		return Center(
			child: Container(
				width: 100,
				height: 100,
				decoration: BoxDecoration(
					color: _cOrangeLight,
					shape: BoxShape.circle,
					border: Border.all(color: _cOrange, width: 1),
				),
				child: const Icon(
					Icons.gpp_maybe_outlined,
					color: _cOrange,
					size: 44,
				),
			),
		);
	}

	Widget _buildOtpRow() {
		return Row(
			mainAxisAlignment: MainAxisAlignment.center,
			children: List.generate(6, (index) {
				return Padding(
					padding: EdgeInsets.only(right: index < 5 ? 10 : 0),
					child: _OtpBox(
						controller: _controllers[index],
						focusNode: _focusNodes[index],
						isActive: index == _activeIndex,
						onChanged: (v) => _onOtpChanged(index, v),
						onTap: () => setState(() => _activeIndex = index),
					),
				);
			}),
		);
	}

	Widget _buildResendRow() {
		return Center(
			child: RichText(
				text: TextSpan(
					style: const TextStyle(fontSize: 14, height: 1.4),
					children: [
						TextSpan(
							text: "Didn't receive the code? ",
							style: TextStyle(color: _cTextSecondary),
						),
						const TextSpan(
							text: 'Resend in 0:45',
							style: TextStyle(
								color: _cTextMuted,
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

class _OtpBox extends StatelessWidget {
	final TextEditingController controller;
	final FocusNode focusNode;
	final bool isActive;
	final ValueChanged<String> onChanged;
	final VoidCallback onTap;

	const _OtpBox({
		required this.controller,
		required this.focusNode,
		required this.isActive,
		required this.onChanged,
		required this.onTap,
	});

	@override
	Widget build(BuildContext context) {
		return GestureDetector(
			onTap: onTap,
			child: Container(
				width: 48,
				height: 56,
				decoration: BoxDecoration(
					color: _cSurface,
					borderRadius: BorderRadius.circular(12),
					border: Border.all(
						color: isActive ? _cPrimary : _cBorder,
						width: isActive ? 2 : 1,
					),
				),
				child: TextField(
					controller: controller,
					focusNode: focusNode,
					textAlign: TextAlign.center,
					textAlignVertical: TextAlignVertical.center,
					keyboardType: TextInputType.number,
					maxLength: 1,
					style: const TextStyle(
						color: _cTextPrimary,
						fontSize: 24,
						fontWeight: FontWeight.bold,
					),
					decoration: const InputDecoration(
						counterText: '',
						border: InputBorder.none,
						contentPadding: EdgeInsets.zero,
					),
					onChanged: onChanged,
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