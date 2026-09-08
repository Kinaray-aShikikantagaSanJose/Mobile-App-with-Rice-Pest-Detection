import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../app_router.dart';
import '../main.dart' show cameras;

@Preview(name: 'F31CameraUi', size: Size(390.0, 844.0))
Widget previewF31CameraUi() {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: F31CameraUi(),
  );
}

class F31CameraUi extends StatefulWidget {
  const F31CameraUi({super.key});
  @override
  F31CameraUiState createState() => F31CameraUiState();
}

class F31CameraUiState extends State<F31CameraUi> with WidgetsBindingObserver {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  bool _isCapturing = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setupCamera();
  }

  void _setupCamera() {
    if (cameras.isEmpty) {
      setState(() {
        _errorMessage = 'No camera was found on this device.';
      });
      return;
    }

    final CameraDescription backCamera = cameras.firstWhere(
          (c) => c.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );

    final controller = CameraController(
      backCamera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    _controller = controller;
    _initializeControllerFuture = controller.initialize().then((_) {
      if (!mounted) return;
      setState(() => _errorMessage = null);
    }).catchError((Object e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e is CameraException
            ? 'Camera error: ${e.description ?? e.code}'
            : 'Could not start the camera.';
      });
    });
  }

  // Cameras must be released when the app is backgrounded and
  // re-acquired on resume, or the preview freezes / throws on Android.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;

    if (state == AppLifecycleState.inactive) {
      controller.dispose();
      _controller = null;
    } else if (state == AppLifecycleState.resumed) {
      _setupCamera();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _captureAndSave() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized || _isCapturing) {
      return;
    }

    setState(() => _isCapturing = true);
    try {
      final XFile shot = await controller.takePicture();

      // Save into the app's own sandboxed local storage (Application
      // Documents directory) — NOT external/shared storage. No
      // WRITE_EXTERNAL_STORAGE permission or gallery/MediaStore write is
      // used, so the scan stays private to this app and is removed
      // automatically if the app is uninstalled.
      final Directory localDir = await getApplicationDocumentsDirectory();
      final Directory trapDir = Directory(p.join(localDir.path, 'trap_scans'));
      if (!await trapDir.exists()) {
        await trapDir.create(recursive: true);
      }

      final String fileName = 'scan_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String savedPath = p.join(trapDir.path, fileName);
      await File(shot.path).copy(savedPath);

      if (!mounted) return;
      context.push(AppRouter.imageCaptured, extra: savedPath);
    } catch (e) {
      if (!mounted) return;
      setState(() => _errorMessage = 'Failed to save the photo. Please try again.');
    } finally {
      if (mounted) setState(() => _isCapturing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Live camera preview (replaces the old placeholder image)
          Positioned.fill(child: _buildCameraPreview()),

          // UI Overlays
          SafeArea(
            child: Column(
              children: [
                _buildTopBar(),
                Expanded(
                  child: Center(
                    child: _buildAlignmentFrame(),
                  ),
                ),
                _buildBottomControls(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraPreview() {
    if (_errorMessage != null) {
      return Container(
        color: Colors.black,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Text(
          _errorMessage!,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      );
    }

    final controller = _controller;
    if (controller == null || _initializeControllerFuture == null) {
      return const ColoredBox(
        color: Colors.black,
        child: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const ColoredBox(
            color: Colors.black,
            child: Center(child: CircularProgressIndicator(color: Colors.white)),
          );
        }
        return FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: controller.value.previewSize?.height ?? 1,
            height: controller.value.previewSize?.width ?? 1,
            child: CameraPreview(controller),
          ),
        );
      },
    );
  }

  Widget _buildTopBar() {
    return Container(
      color: Colors.black.withValues(alpha: 0.6),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => context.pop(),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0x33FFFFFF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                ),
              ),
              const Text(
                "Scan Sticky Trap",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () => debugPrint('Flash toggle pressed'),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0x33FFFFFF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.flash_off, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAlignmentFrame() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Guide Brackets
        Container(
          width: 280,
          height: 380,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1),
            borderRadius: BorderRadius.circular(24),
          ),
        ),

        // Instruction Tooltip
        Positioned(
          top: 40,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xCC121824),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
            ),
            child: const Text(
              "Align sticky trap within the frame",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // Corner Indicators
        const Positioned(top: 0, left: 0, child: _CornerBracket(isTop: true, isLeft: true)),
        const Positioned(top: 0, right: 0, child: _CornerBracket(isTop: true, isLeft: false)),
        const Positioned(bottom: 0, left: 0, child: _CornerBracket(isTop: false, isLeft: true)),
        const Positioned(bottom: 0, right: 0, child: _CornerBracket(isTop: false, isLeft: false)),
      ],
    );
  }

  Widget _buildBottomControls() {
    return Container(
      color: Colors.black.withValues(alpha: 0.6),
      padding: const EdgeInsets.fromLTRB(40, 24, 40, 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => debugPrint('Gallery pressed'),
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0x33FFFFFF),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.photo_library_outlined, color: Colors.white, size: 22),
            ),
          ),

          // Shutter Button
          GestureDetector(
            onTap: _isCapturing ? null : _captureAndSave,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0x33FFFFFF),
                shape: BoxShape.circle,
              ),
              child: Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: _isCapturing
                    ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black54),
                )
                    : null,
              ),
            ),
          ),

          InkWell(
            onTap: () => debugPrint('Camera flip pressed'),
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0x33FFFFFF),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.flip_camera_ios_outlined, color: Colors.white, size: 22),
            ),
          ),
        ],
      ),
    );
  }
}

class _CornerBracket extends StatelessWidget {
  final bool isTop;
  final bool isLeft;
  const _CornerBracket({required this.isTop, required this.isLeft});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
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
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double x = isLeft ? 0 : size.width;
    final double y = isTop ? 0 : size.height;
    final Offset corner = Offset(x, y);

    canvas.drawLine(corner, Offset(x, isTop ? size.height : 0), paint);
    canvas.drawLine(corner, Offset(isLeft ? size.width : 0, y), paint);
  }

  @override
  bool shouldRepaint(covariant _BracketPainter oldDelegate) => false;
}