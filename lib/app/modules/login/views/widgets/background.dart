import 'package:flutter/material.dart';
import 'dart:ui';

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.6, 1, 1.0],
              colors: [
                Colors.white,
                Color(0xFFf8f9ff),
                Color(0xFF4285f4),
                Color(0xFF1976d2),
              ],
            ),
          ),
        ),
        
        // Blurred circles
        const _BlurredCircle(
          bottom: -150,
          right: -100,
          width: 400,
          height: 400,
          colors: [
            Color.fromARGB(153, 66, 133, 244),
            Color.fromARGB(76, 25, 118, 210),
            Colors.transparent,
          ],
          stops: [0.0, 0.7, 1.0],
        ),
        
        const _BlurredCircle(
          bottom: -200,
          left: -150,
          width: 500,
          height: 500,
          colors: [
            Color.fromARGB(102, 124, 77, 255),
            Color.fromARGB(51, 63, 81, 181),
            Colors.transparent,
          ],
          stops: [0.0, 0.6, 1.0],
        ),
        
        const _BlurredCircle(
          top: 100,
          right: -80,
          width: 200,
          height: 200,
          colors: [
            Color.fromARGB(76, 227, 242, 253),
            Colors.transparent,
          ],
          stops: [0.0, 1.0],
        ),
        
        // Blur effect
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
          child: Container(color: Colors.transparent),
        ),
      ],
    );
  }
}

class _BlurredCircle extends StatelessWidget {
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final double width;
  final double height;
  final List<Color> colors;
  final List<double> stops;

  const _BlurredCircle({
    this.top,
    this.bottom,
    this.left,
    this.right,
    required this.width,
    required this.height,
    required this.colors,
    required this.stops,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: colors,
            stops: stops,
          ),
        ),
      ),
    );
  }
}
