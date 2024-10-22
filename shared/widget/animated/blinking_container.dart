import 'package:flutter/material.dart';

class BlinkingContainer extends StatefulWidget {
  final Widget child;

  const BlinkingContainer({super.key, required this.child});

  @override
  State<BlinkingContainer> createState() => _BlinkingContainerState();
}

class _BlinkingContainerState extends State<BlinkingContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  Widget build(final BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.25,
      upperBound: 1,
    );
    _animationController.repeat(reverse: true);
    super.initState();
  }
}
