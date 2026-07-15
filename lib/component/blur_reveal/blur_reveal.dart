import 'dart:ui';
import 'package:flutter/material.dart';

class BlurReveal extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double initialBlur;

  const BlurReveal({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.initialBlur = 15.0,
  });

  @override
  State<BlurReveal> createState() => _BlurRevealState();
}

class _BlurRevealState extends State<BlurReveal> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _blurAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _blurAnimation = Tween<double>(begin: widget.initialBlur, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _blurAnimation,
      builder: (context, child) {
        if (_blurAnimation.value == 0) return widget.child;
        
        return ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: _blurAnimation.value,
            sigmaY: _blurAnimation.value,
          ),
          child: widget.child,
        );
      },
    );
  }
}
