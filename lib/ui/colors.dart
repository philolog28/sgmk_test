import 'package:flutter/material.dart';

abstract class UIColors {
  static const scaffoldColor = Color(0xFFFFFFFF);
  static const primaryColor = Color(0xFFF43F5E);
  static const shadowsColor = Color(0xFF5A6CEA);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF09101D);
  static const coursorColor = Color(0xFF393E46);
  static const border = Color(0xFFC7CAD1);
  static const gradientColor1 = Color(0xFFFF7E95);
  static const gradientColor2 = Color(0xFFFF1843);
}

abstract class UIGradient {
  static const gradientPrimary = LinearGradient(
      colors: [UIColors.gradientColor1, UIColors.gradientColor2]);
  static final gradientScaffold = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.white.withOpacity(0), Colors.white.withOpacity(1)]);
}

class GradientMask extends StatelessWidget {
  const GradientMask({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.modulate,
      shaderCallback: (bounds) {
        return UIGradient.gradientPrimary.createShader(bounds);
      },
      child: child,
    );
  }
}
