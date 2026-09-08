import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import '../app_router.dart';

@Preview(name: 'F32ImageCaptured', size: Size(390.0, 844.0))
Widget previewF32ImageCaptured() {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: F32ImageCaptured(imagePath: 'dummy_path.jpg'),
  );
}

class F32ImageCaptured extends StatefulWidget {
  final String imagePath;
  const F32ImageCaptured({super.key, required this.imagePath});
  @override
  F32ImageCapturedState createState() => F32ImageCapturedState();
}

class F32ImageCapturedState extends State<F32ImageCaptured> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            _buildTopBar(),

            // Image Preview (Responsive)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    _buildHeader(),
                    const SizedBox(height: 20),
                    _buildImagePreview(),
                    const SizedBox(height: 16),
                    _buildQualityBadge(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Action Buttons
            _buildActionButtons(),

            // Home Indicator
            const _HomeIndicator(),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return const SizedBox(height: 12);
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => context.pop(),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE5E0D8), width: 1),
                ),
                child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Color(0xFF1B4332)),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              "Review Capture",
              style: TextStyle(
                color: Color(0xFF1B4332),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () => debugPrint('Info pressed'),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE5E0D8), width: 1),
            ),
            child: const Icon(Icons.info_outline, size: 20, color: Color(0xFF1B4332)),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePreview() {
    final bool hasFile = widget.imagePath.isNotEmpty;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxHeight: 450, minHeight: 240),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: hasFile
            ? Image.file(
          File(widget.imagePath),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildImagePlaceholder(),
        )
            : _buildImagePlaceholder(),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      color: const Color(0xFFE5E0D8),
      alignment: Alignment.center,
      child: const Icon(
        Icons.image_not_supported_outlined,
        size: 48,
        color: Color(0xFF8E9E90),
      ),
    );
  }

  Widget _buildQualityBadge() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F9F3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2D6A4F), width: 1),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, size: 14, color: Color(0xFF2D6A4F)),
            SizedBox(width: 6),
            Text(
              "Saved locally on this device",
              style: TextStyle(
                color: Color(0xFF1B4332),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: _ActionButton(
              label: "Retake",
              isPrimary: false,
              onTap: () => _discardAndRetake(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _ActionButton(
              label: "Confirm & Continue",
              isPrimary: true,
              onTap: () => context.push(AppRouter.fieldNotes, extra: widget.imagePath),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _discardAndRetake(BuildContext context) async {
    // Clean up the locally saved file the user is discarding so rejected
    // scans don't pile up in local storage.
    if (widget.imagePath.isNotEmpty) {
      final file = File(widget.imagePath);
      try {
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        debugPrint('Could not delete discarded scan: $e');
      }
    }
    if (context.mounted) context.pop();
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;
  const _ActionButton({required this.label, required this.isPrimary, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 17),
        decoration: BoxDecoration(
          color: isPrimary ? const Color(0xFF2D6A4F) : Colors.white,
          borderRadius: BorderRadius.circular(100),
          border: isPrimary ? null : Border.all(color: const Color(0xFFE5E0D8)),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isPrimary ? Colors.white : const Color(0xFF5C6B5E),
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
    return Center(
      child: Container(
        width: 134,
        height: 5,
        decoration: BoxDecoration(
          color: const Color(0xFF1B4332),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}