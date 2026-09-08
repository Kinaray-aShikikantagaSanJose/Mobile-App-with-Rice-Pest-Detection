import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_router.dart';
import 'auth_controller.dart';

/// Cameras available on this device. Populated once at startup and read
/// by F31CameraUi (`import '../main.dart' show cameras;`) so the camera
/// screen doesn't need to re-enumerate devices or thread the list through
/// go_router's `extra`.
List<CameraDescription> cameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    debugPrint('Camera init error: ${e.code} ${e.description}');
  } catch (e) {
    debugPrint('Camera init error (non-camera-specific): $e');
  }

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AuthController auth = AuthControllerImpl();
  late final AppRouter _appRouter = AppRouter(auth);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Rice Pest Monitor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2D6A4F)),
        useMaterial3: true,
      ),
      routerConfig: _appRouter.router,
    );
  }
}