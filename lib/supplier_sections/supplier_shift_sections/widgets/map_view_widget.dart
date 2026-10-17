import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MapViewWidget extends StatelessWidget {
  final String locationTag;
  final bool showArrivalRadius;
  final bool isInsideRadius;

  const MapViewWidget({
    super.key,
    this.locationTag = 'PEELAMEDU · VENUE & ARRIVAL AREA',
    this.showArrivalRadius = true,
    this.isInsideRadius = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180.h,
      decoration: BoxDecoration(
        color: const Color(0xFFEBF3EE),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFCBD5E1), width: 1.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          children: [
            // Custom Painter to draw roads, city grid, route, and pins
            Positioned.fill(
              child: CustomPaint(
                painter: _MapPainter(
                  showArrivalRadius: showArrivalRadius,
                  isInsideRadius: isInsideRadius,
                ),
              ),
            ),

            // Top Location Badge
            Positioned(
              top: 12.h,
              left: 12.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(6.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  locationTag,
                  style: GoogleFonts.inter(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F766E),
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  final bool showArrivalRadius;
  final bool isInsideRadius;

  _MapPainter({
    required this.showArrivalRadius,
    required this.isInsideRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundRoadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 14.0
      ..style = PaintingStyle.stroke;

    final thinRoadPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 6.0
      ..style = PaintingStyle.stroke;

    final blockPaint = Paint()
      ..color = const Color(0xFFD8E8DD)
      ..style = PaintingStyle.fill;

    // Draw some city blocks
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(20, 20, 70, 45),
        const Radius.circular(6),
      ),
      blockPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(110, 20, 90, 40),
        const Radius.circular(6),
      ),
      blockPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(220, 25, 80, 50),
        const Radius.circular(6),
      ),
      blockPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(30, 90, 100, 60),
        const Radius.circular(6),
      ),
      blockPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(160, 100, 120, 55),
        const Radius.circular(6),
      ),
      blockPaint,
    );

    // Draw roads
    canvas.drawLine(
      Offset(0, size.height * 0.45),
      Offset(size.width, size.height * 0.45),
      backgroundRoadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.35, 0),
      Offset(size.width * 0.35, size.height),
      backgroundRoadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.72, 0),
      Offset(size.width * 0.72, size.height),
      backgroundRoadPaint,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.8),
      Offset(size.width, size.height * 0.8),
      thinRoadPaint,
    );

    // Draw route path (Teal/Green line)
    final routePaint = Paint()
      ..color = const Color(0xFF0F766E)
      ..strokeWidth = 4.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(size.width * 0.18, size.height * 0.65);
    path.lineTo(size.width * 0.35, size.height * 0.65);
    path.lineTo(size.width * 0.35, size.height * 0.45);
    path.lineTo(size.width * 0.72, size.height * 0.45);
    path.lineTo(size.width * 0.72, size.height * 0.35);
    canvas.drawPath(path, routePaint);

    final venueOffset = Offset(size.width * 0.72, size.height * 0.35);

    // Draw 200m geofence circle around venue
    if (showArrivalRadius) {
      final radiusPaint = Paint()
        ..color = isInsideRadius
            ? const Color(0xFF22C55E).withValues(alpha: 0.22)
            : const Color(0xFFEF4444).withValues(alpha: 0.18)
        ..style = PaintingStyle.fill;

      final radiusBorderPaint = Paint()
        ..color = isInsideRadius
            ? const Color(0xFF16A34A).withValues(alpha: 0.7)
            : const Color(0xFFDC2626).withValues(alpha: 0.6)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke;

      canvas.drawCircle(venueOffset, 38.0, radiusPaint);
      canvas.drawCircle(venueOffset, 38.0, radiusBorderPaint);
    }

    // Destination Pin (Venue)
    _drawPin(canvas, venueOffset, const Color(0xFFDC2626));

    // User Location Pin
    final userOffset = isInsideRadius
        ? Offset(venueOffset.dx - 18, venueOffset.dy + 15) // inside 40m
        : Offset(size.width * 0.18, size.height * 0.65); // outside 4.2km

    _drawUserMarker(canvas, userOffset);
  }

  void _drawPin(Canvas canvas, Offset offset, Color color) {
    final pinPaint = Paint()..color = color;
    canvas.drawCircle(offset, 6.0, pinPaint);
    final dotPaint = Paint()..color = Colors.white;
    canvas.drawCircle(offset, 2.5, dotPaint);
  }

  void _drawUserMarker(Canvas canvas, Offset offset) {
    final pulsePaint = Paint()
      ..color = const Color(0xFF0F766E).withValues(alpha: 0.25);
    canvas.drawCircle(offset, 10.0, pulsePaint);

    final markerPaint = Paint()..color = const Color(0xFF0F766E);
    canvas.drawCircle(offset, 5.0, markerPaint);

    final innerPaint = Paint()..color = Colors.white;
    canvas.drawCircle(offset, 2.0, innerPaint);
  }

  @override
  bool shouldRepaint(covariant _MapPainter oldDelegate) {
    return oldDelegate.isInsideRadius != isInsideRadius ||
        oldDelegate.showArrivalRadius != showArrivalRadius;
  }
}
