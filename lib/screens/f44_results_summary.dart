import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import '../app_router.dart';

@Preview(name: 'F44ResultsSummary', size: Size(390.0, 844.0))
Widget previewF44ResultsSummary() {
	return const MaterialApp(
		debugShowCheckedModeBanner: false,
		home: F44ResultsSummary(detection: null),
	);
}

class F44ResultsSummary extends StatefulWidget {
	final dynamic detection;
	const F44ResultsSummary({super.key, this.detection});
	@override
	F44ResultsSummaryState createState() => F44ResultsSummaryState();
}

class F44ResultsSummaryState extends State<F44ResultsSummary> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: SafeArea(
				child: Container(
					color: const Color(0xFFFFFFFF),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Expanded(
								child: Container(
									decoration: BoxDecoration(
										border: Border.all(color: const Color(0xFFE5E0D8), width: 1),
										color: const Color(0xFFFAF8F5),
									),
									width: double.infinity,
									child: SingleChildScrollView(
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [
												_buildHeader(),
												Padding(
													padding: const EdgeInsets.symmetric(horizontal: 24),
													child: Column(
														crossAxisAlignment: CrossAxisAlignment.start,
														children: [
															_buildScanInfoCard(),
															const SizedBox(height: 16),
															_buildPestDetailsBlock(),
															const SizedBox(height: 24),
															_buildTreatmentPlanCard(),
														],
													),
												),
												const SizedBox(height: 50),
											],
										),
									),
								),
							),
							_buildBottomBar(context),
						],
					),
				),
			),
		);
	}

	Widget _buildHeader() {
		return Padding(
			padding: const EdgeInsets.symmetric(vertical: 8),
			child: Row(
				children: [
					Container(
						margin: const EdgeInsets.only(left: 24, right: 16),
						width: 40,
						height: 40,
						decoration: const BoxDecoration(
							color: Color(0xFFD8F3DC),
							shape: BoxShape.circle,
						),
						child: const Icon(Icons.eco_outlined, size: 20, color: Color(0xFF2D6A4F)),
					),
					const Text(
						"Scan Results",
						style: TextStyle(
							color: Color(0xFF1B4332),
							fontSize: 20,
							fontWeight: FontWeight.bold,
						),
					),
				],
			),
		);
	}

	Widget _buildScanInfoCard() {
		return Container(
			decoration: BoxDecoration(
				border: Border.all(color: const Color(0xFFE5E0D8), width: 1),
				borderRadius: BorderRadius.circular(16),
				color: const Color(0xFFFFFFFF),
			),
			padding: const EdgeInsets.all(12),
			width: double.infinity,
			child: Row(
				children: [
					Container(
						margin: const EdgeInsets.only(right: 16),
						width: 72,
						height: 72,
						child: ClipRRect(
							borderRadius: BorderRadius.circular(8),
							child: Image.network(
								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/yQk73Zdz3g/0rxs1ti7_expires_30_days.png",
								fit: BoxFit.cover,
							),
						),
					),
					const Expanded(
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Text(
									"SCANNED TODAY AT 10:42 AM",
									style: TextStyle(
										color: Color(0xFF5C6B5E),
										fontSize: 12,
										fontWeight: FontWeight.bold,
									),
								),
								SizedBox(height: 4),
								Text(
									"Field Block A-1",
									style: TextStyle(
										color: Color(0xFF1B4332),
										fontSize: 16,
										fontWeight: FontWeight.bold,
									),
								),
								SizedBox(height: 4),
								Text(
									"Central Luzon (Region III)",
									style: TextStyle(
										color: Color(0xFF5C6B5E),
										fontSize: 13,
									),
								),
							],
						),
					),
				],
			),
		);
	}

	Widget _buildPestDetailsBlock() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				Container(
					decoration: BoxDecoration(
						border: Border.all(color: const Color(0xFFE5E0D8), width: 1),
						borderRadius: BorderRadius.circular(16),
						color: const Color(0xFFFFFFFF),
					),
					padding: const EdgeInsets.symmetric(vertical: 16),
					width: double.infinity,
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							const Padding(
								padding: EdgeInsets.only(left: 16, bottom: 8),
								child: Text(
									"Dominant Pest Species",
									style: TextStyle(
										color: Color(0xFF5C6B5E),
										fontSize: 11,
										fontWeight: FontWeight.bold,
									),
								),
							),
							Padding(
								padding: const EdgeInsets.only(left: 16, bottom: 8),
								child: Row(
									mainAxisSize: MainAxisSize.min,
									children: const [
										Icon(Icons.bug_report_outlined, size: 20, color: Color(0xFF1B4332)),
										SizedBox(width: 8),
										Text(
											"Brown Planthopper",
											style: TextStyle(
												color: Color(0xFF1B4332),
												fontSize: 18,
												fontWeight: FontWeight.bold,
											),
										),
									],
								),
							),
							const Padding(
								padding: EdgeInsets.only(left: 16),
								child: Text(
									"(Nilaparvata lugens)",
									style: TextStyle(
										color: Color(0xFF5C6B5E),
										fontSize: 13,
									),
								),
							),
						],
					),
				),
				const SizedBox(height: 12),
				Row(
					children: [
						Expanded(
							child: Container(
								decoration: BoxDecoration(
									border: Border.all(color: const Color(0xFFE5E0D8), width: 1),
									borderRadius: BorderRadius.circular(16),
									color: const Color(0xFFFFFFFF),
								),
								padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16),
								margin: const EdgeInsets.only(right: 12),
								child: const Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Text(
											"Pests Detected",
											style: TextStyle(
												color: Color(0xFF5C6B5E),
												fontSize: 11,
												fontWeight: FontWeight.bold,
											),
										),
										SizedBox(height: 4),
										Text(
											"42 Pests",
											style: TextStyle(
												color: Color(0xFF1B4332),
												fontSize: 22,
												fontWeight: FontWeight.bold,
											),
										),
										SizedBox(height: 4),
										Text(
											"16.8 pests / m²",
											style: TextStyle(
												color: Color(0xFF5C6B5E),
												fontSize: 11,
											),
										),
									],
								),
							),
						),
						Expanded(
							child: Container(
								decoration: BoxDecoration(
									border: Border.all(color: const Color(0xFFFFD8D8), width: 1),
									borderRadius: BorderRadius.circular(16),
									color: const Color(0xFFFFF2F2),
								),
								padding: const EdgeInsets.symmetric(vertical: 16),
								child: const Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Padding(
											padding: EdgeInsets.only(left: 16),
											child: Text(
												"Severity Class",
												style: TextStyle(
													color: Color(0xFFE63946),
													fontSize: 11,
													fontWeight: FontWeight.bold,
												),
											),
										),
										SizedBox(height: 4),
										Padding(
											padding: EdgeInsets.only(left: 16),
											child: Row(
												mainAxisSize: MainAxisSize.min,
												children: [
													Icon(Icons.warning_amber_rounded, size: 16, color: Color(0xFFE63946)),
													SizedBox(width: 6),
													Text(
														"HIGH",
														style: TextStyle(
															color: Color(0xFFE63946),
															fontSize: 22,
															fontWeight: FontWeight.bold,
														),
													),
												],
											),
										),
										SizedBox(height: 4),
										Padding(
											padding: EdgeInsets.only(left: 16),
											child: Text(
												"Immediate action advised",
												style: TextStyle(
													color: Color(0xFFE63946),
													fontSize: 11,
												),
											),
										),
									],
								),
							),
						),
					],
				),
			],
		);
	}

	Widget _buildTreatmentPlanCard() {
		return Container(
			decoration: BoxDecoration(
				borderRadius: BorderRadius.circular(20),
				color: const Color(0xFFD8F3DC),
			),
			padding: const EdgeInsets.only(top: 16, bottom: 16, right: 16, left: 16),
			width: double.infinity,
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: const [
					Text(
						"Recommended Treatment Plan",
						style: TextStyle(
							color: Color(0xFF1B4332),
							fontSize: 13,
							fontWeight: FontWeight.bold,
						),
					),
					SizedBox(height: 12),
					_TreatmentStep(number: "1.", text: "Apply Imidacloprid at 0.5ml/L within 48 hours."),
					SizedBox(height: 10),
					_TreatmentStep(number: "2.", text: "Drain field water for 3-5 days to limit reproduction."),
					SizedBox(height: 10),
					_TreatmentStep(number: "3.", text: "Schedule a follow-up scan in 7 days to evaluate efficacy."),
				],
			),
		);
	}

	Widget _buildBottomBar(BuildContext context) {
		return Container(
			color: const Color(0xFFFAF8F5),
			padding: const EdgeInsets.only(top: 16, bottom: 16, left: 24, right: 24),
			width: double.infinity,
			child: Column(
				children: [
					InkWell(
						onTap: () => context.go(AppRouter.syncComplete, extra: 'REC123'),
						borderRadius: BorderRadius.circular(100),
						child: Container(
							decoration: BoxDecoration(
								borderRadius: BorderRadius.circular(100),
								color: const Color(0xFF2D6A4F),
							),
							padding: const EdgeInsets.symmetric(vertical: 18),
							width: double.infinity,
							alignment: Alignment.center,
							child: const Text(
								"Finish & Return to Home",
								style: TextStyle(
									color: Color(0xFFFFFFFF),
									fontSize: 15,
									fontWeight: FontWeight.bold,
								),
							),
						),
					),
					const SizedBox(height: 14),
					Center(
						child: Container(
							decoration: BoxDecoration(
								borderRadius: BorderRadius.circular(2),
								color: const Color(0xFF1B4332),
							),
							width: 134,
							height: 5,
						),
					),
				],
			),
		);
	}
}

class _TreatmentStep extends StatelessWidget {
	final String number;
	final String text;
	const _TreatmentStep({required this.number, required this.text});

	@override
	Widget build(BuildContext context) {
		return Row(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				Padding(
					padding: const EdgeInsets.only(right: 10),
					child: Text(
						number,
						style: const TextStyle(
							color: Color(0xFF1B4332),
							fontSize: 14,
							fontWeight: FontWeight.bold,
						),
					),
				),
				Expanded(
					child: Text(
						text,
						style: const TextStyle(
							color: Color(0xFF1B4332),
							fontSize: 14,
						),
					),
				),
			],
		);
	}
}