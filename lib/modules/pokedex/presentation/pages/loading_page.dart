import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokedex/modules/pokedex/core/constants/constants.dart';
import 'package:pokedex/modules/pokedex/core/constants/images.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3FCFF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.pokeball.assetName),
            Text(
              loadingPhrases[Random().nextInt(loadingPhrases.length)],
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
