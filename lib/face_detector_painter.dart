// lib/face_detector_painter.dart
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:camera/camera.dart';

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(
    this.faces,
    this.absoluteImageSize,
    this.rotation,
    this.cameraLensDirection,
  );

  final List<Face> faces;
  final Size absoluteImageSize; // InputImage metadata size
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;

  // Styling
  final _boxPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3
    ..color = Colors.lightBlueAccent;

  final _bgPaint = Paint()
    ..style = PaintingStyle.fill
    ..color = const Color(0xAA000000);

  @override
  void paint(Canvas canvas, Size size) {
    if (absoluteImageSize == Size.zero) return;

    for (final face in faces) {
      // Map MLKit rect into the canvas space
      final rect = _scaleRect(
        face.boundingBox,
        size,
        absoluteImageSize,
        cameraLensDirection == CameraLensDirection.front,
      );

      // Draw box
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(10)),
        _boxPaint,
      );

      // Build label lines
      final lines = _buildLabel(face);

      // Draw label bubble above the box
      final textSpan = TextSpan(
        text: lines.join('\n'),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          height: 1.25,
          fontWeight: FontWeight.w600,
        ),
      );
      final tp = TextPainter(
        text: textSpan,
        textAlign: TextAlign.left,
        textDirection: ui.TextDirection.ltr,
      )..layout(maxWidth: size.width * 0.6);

      // Bubble rect
      const pad = 8.0;
      final labelW = tp.width + pad * 2;
      final labelH = tp.height + pad * 2;

      var bubbleLeft = rect.left;
      var bubbleTop = rect.top - labelH - 6;
      if (bubbleLeft + labelW > size.width) {
        bubbleLeft = size.width - labelW - 4;
      }
      if (bubbleTop < 4) {
        bubbleTop = rect.bottom + 6;
      }

      final bubble = Rect.fromLTWH(bubbleLeft, bubbleTop, labelW, labelH);
      final rrect = RRect.fromRectAndRadius(bubble, const Radius.circular(8));
      canvas.drawRRect(rrect, _bgPaint);
      tp.paint(canvas, Offset(bubbleLeft + pad, bubbleTop + pad));
    }
  }

  // Build user-friendly labels for one face
  List<String> _buildLabel(Face f) {
    final List<String> out = [];

    // Emotion (smile)
    final sp = f.smilingProbability;
    if (sp != null) {
      String mood;
      if (sp >= 0.6) {
        mood = '😀 Happy';
      } else if (sp >= 0.3) {
        mood = '😐 Neutral';
      } else {
        mood = '🙁 Sad';
      }
      out.add('$mood (${(sp * 100).toStringAsFixed(0)}%)');
    } else {
      out.add('Emotion: N/A');
    }

    // Eyes (if available)
    final le = f.leftEyeOpenProbability;
    final re = f.rightEyeOpenProbability;
    if (le != null || re != null) {
      final l = le != null ? '${(le * 100).toStringAsFixed(0)}%' : '—';
      final r = re != null ? '${(re * 100).toStringAsFixed(0)}%' : '—';
      out.add('Eyes: L $l | R $r');
    }

    // Orientation from Euler angles
    final rx = f.headEulerAngleX ?? 0; // up/down
    final ry = f.headEulerAngleY ?? 0; // left/right (yaw)
    final rz = f.headEulerAngleZ ?? 0; // tilt (roll)

    out.add('Dir: ${_directionFromYaw(ry)}');
    out.add(
      'Tilt: ${rz.toStringAsFixed(0)}°  Pitch: ${rx.toStringAsFixed(0)}°',
    );

    // Tracking ID
    if (f.trackingId != null) {
      out.add('ID: ${f.trackingId}');
    }

    return out;
  }

  String _directionFromYaw(double ry) {
    // ry > 0 -> turned right; ry < 0 -> turned left (ML Kit coordinate space)
    // Thresholds in degrees
    if (ry > 20) return 'Right';
    if (ry < -20) return 'Left';
    // Between ±20 considered front; we can refine with pitch (rx) too if wanted
    return 'Front';
  }

  // Map MLKit bounding box to the canvas coordinates (portrait)
  Rect _scaleRect(
    Rect r,
    Size canvasSize,
    Size imageSize,
    bool mirrorHorizontallyForFrontCamera,
  ) {
    // ML Kit gives image in its native orientation; for portrait preview we swap width/height.
    final imageW = imageSize.height;
    final imageH = imageSize.width;

    final scaleX = canvasSize.width / imageW;
    final scaleY = canvasSize.height / imageH;

    double left = r.left * scaleX;
    double top = r.top * scaleY;
    double right = r.right * scaleX;
    double bottom = r.bottom * scaleY;

    if (mirrorHorizontallyForFrontCamera) {
      final newLeft = canvasSize.width - right;
      final newRight = canvasSize.width - left;
      left = newLeft;
      right = newRight;
    }

    return Rect.fromLTRB(left, top, right, bottom);
  }

  @override
  bool shouldRepaint(covariant FaceDetectorPainter old) {
    return old.faces != faces ||
        old.absoluteImageSize != absoluteImageSize ||
        old.rotation != rotation ||
        old.cameraLensDirection != cameraLensDirection;
  }
}
