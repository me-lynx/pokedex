import 'dart:math';

import 'package:flutter/material.dart';

class _BoxDecoration extends StatelessWidget {
  static const Size size = Size.square(144);

  const _BoxDecoration();

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi * 5 / 12,
      alignment: Alignment.center,
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: const Alignment(-0.2, -0.2),
            end: const Alignment(1.5, -0.3),
            colors: [
              Colors.white.withOpacity(0.3),
              Colors.white.withOpacity(0),
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundDecoration extends StatefulWidget {
  const BackgroundDecoration({super.key});

  @override
  State<BackgroundDecoration> createState() => BackgroundDecorationState();
}

class BackgroundDecorationState extends State<BackgroundDecoration> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildBackground(),
        buildBoxDecoration(),
      ],
    );
  }

  Widget buildBackground() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      constraints: const BoxConstraints.expand(),
      color: Colors.red,
    );
  }

  Widget buildBoxDecoration() {
    return Positioned(
      top: -_BoxDecoration.size.height * 0.4,
      left: -_BoxDecoration.size.width * 0.4,
      child: const _BoxDecoration(),
    );
  }
}
