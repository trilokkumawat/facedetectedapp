import 'package:camera/camera.dart';
import 'package:facedetecteapp/FaceDetectionScreen.dart';
import 'package:flutter/material.dart';

late final List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF21ACEA);
    final scheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.dark,
    );

    return MaterialApp(
      title: 'Face Detection Demo',
      theme: ThemeData(
        useMaterial3: false,
        brightness: Brightness.dark,
        colorScheme: scheme,
        scaffoldBackgroundColor: const Color(0xFF121417),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121417),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: FaceDetectorView(),
    );
  }
}
