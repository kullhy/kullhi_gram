import 'package:flutter/material.dart';
import 'package:min_soft_ware/src/configs/palette.dart';
import 'package:min_soft_ware/src/gen/assets.gen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Palette.white,
      width: MediaQuery.of(context).size.width,
      child: Assets.image.logo.image(height: 48, width: 48),
    );
  }
}
