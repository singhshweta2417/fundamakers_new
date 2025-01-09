import 'package:flutter/material.dart';

class DashedBorder extends StatelessWidget {
  final Widget child;
  final Color color;
  final double strokeWidth;
  final double gapWidth;
  final double dashWidth;

  const DashedBorder({
    super.key,
    required this.child,
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.gapWidth = 5.0,
    this.dashWidth = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        color: color,
        strokeWidth: strokeWidth,
        gapWidth: gapWidth,
        dashWidth: dashWidth,
      ),
      child: child,
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gapWidth;
  final double dashWidth;

  DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.gapWidth,
    required this.dashWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double halfStrokeWidth = strokeWidth / 2;
    final double startX = halfStrokeWidth;
    final double endX = size.width - halfStrokeWidth;
    final double startY = halfStrokeWidth;
    final double endY = size.height - halfStrokeWidth;

    // Top border
    double currentX = startX;
    while (currentX < endX) {
      final double newX = currentX + dashWidth;
      canvas.drawLine(
        Offset(currentX, startY),
        Offset(newX > endX ? endX : newX, startY),
        paint,
      );
      currentX += dashWidth + gapWidth;
    }

    // Right border
    double currentY = startY;
    while (currentY < endY) {
      final double newY = currentY + dashWidth;
      canvas.drawLine(
        Offset(endX, currentY),
        Offset(endX, newY > endY ? endY : newY),
        paint,
      );
      currentY += dashWidth + gapWidth;
    }

    // Bottom border
    currentX = endX;
    while (currentX > startX) {
      final double newX = currentX - dashWidth;
      canvas.drawLine(
        Offset(currentX, endY),
        Offset(newX < startX ? startX : newX, endY),
        paint,
      );
      currentX -= dashWidth + gapWidth;
    }

    // Left border
    currentY = endY;
    while (currentY > startY) {
      final double newY = currentY - dashWidth;
      canvas.drawLine(
        Offset(startX, currentY),
        Offset(startX, newY < startY ? startY : newY),
        paint,
      );
      currentY -= dashWidth + gapWidth;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
