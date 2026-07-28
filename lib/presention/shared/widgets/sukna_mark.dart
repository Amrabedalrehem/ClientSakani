import 'package:flutter/material.dart';

class SuknaMark extends StatelessWidget {
  final double size;

  const SuknaMark({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _SuknaMarkPainter(),
      ),
    );
  }
}

class _SuknaMarkPainter extends CustomPainter {
  static const Color _roofColor = Color(0xFF25334D);
  static const Color _bodyColor = Color(0xFF21B5A6);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width * 0.06;
    final thinStroke = size.width * 0.04;

    final roofPaint = Paint()
      ..color = _roofColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final bodyPaint = Paint()
      ..color = _bodyColor
      ..style = PaintingStyle.fill;

    final bodyOutlinePaint = Paint()
      ..color = _roofColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = thinStroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final windowPaint = Paint()
      ..color = Colors.white.withOpacity(0.85)
      ..style = PaintingStyle.fill;

    final accentPaint = Paint()
      ..color = Colors.white.withOpacity(0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = thinStroke * 0.75
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final roofPath = Path()
      ..moveTo(size.width * 0.12, size.height * 0.45)
      ..lineTo(size.width * 0.50, size.height * 0.14)
      ..lineTo(size.width * 0.88, size.height * 0.45)
      ..lineTo(size.width * 0.88, size.height * 0.54)
      ..lineTo(size.width * 0.50, size.height * 0.25)
      ..lineTo(size.width * 0.12, size.height * 0.54)
      ..close();

    final housePath = Path()
      ..moveTo(size.width * 0.18, size.height * 0.48)
      ..lineTo(size.width * 0.18, size.height * 0.80)
      ..lineTo(size.width * 0.82, size.height * 0.80)
      ..lineTo(size.width * 0.82, size.height * 0.55)
      ..lineTo(size.width * 0.68, size.height * 0.47)
      ..close();

    final basePath = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.14,
        size.height * 0.74,
        size.width * 0.72,
        size.height * 0.08,
      ),
      Radius.circular(size.width * 0.03),
    );

    canvas.drawPath(roofPath, roofPaint);
    canvas.drawPath(housePath, bodyPaint);
    canvas.drawPath(housePath, bodyOutlinePaint);
    canvas.drawRRect(basePath, bodyPaint);
    canvas.drawRRect(basePath, bodyOutlinePaint);

    final door = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.44,
        size.height * 0.57,
        size.width * 0.12,
        size.height * 0.23,
      ),
      Radius.circular(size.width * 0.04),
    );
    canvas.drawRRect(door, windowPaint);

    final leftWindow = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.25,
        size.height * 0.60,
        size.width * 0.08,
        size.height * 0.08,
      ),
      Radius.circular(size.width * 0.015),
    );
    final rightWindow = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.67,
        size.height * 0.60,
        size.width * 0.08,
        size.height * 0.08,
      ),
      Radius.circular(size.width * 0.015),
    );
    canvas.drawRRect(leftWindow, windowPaint);
    canvas.drawRRect(rightWindow, windowPaint);

    final accentPath = Path()
      ..moveTo(size.width * 0.22, size.height * 0.53)
      ..lineTo(size.width * 0.22, size.height * 0.70)
      ..lineTo(size.width * 0.34, size.height * 0.70)
      ..moveTo(size.width * 0.50, size.height * 0.37)
      ..lineTo(size.width * 0.50, size.height * 0.64)
      ..lineTo(size.width * 0.62, size.height * 0.64)
      ..moveTo(size.width * 0.70, size.height * 0.53)
      ..lineTo(size.width * 0.70, size.height * 0.70);

    canvas.drawPath(accentPath, accentPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
