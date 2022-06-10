import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sgmk_test/ui/colors.dart';

import '../icons.dart';

class PlusButton extends StatelessWidget {
  const PlusButton({Key? key, required this.onPressed, required this.padding}) : super(key: key);
  final VoidCallback? onPressed;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: padding,
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            decoration: const BoxDecoration(
                gradient: UIGradient.gradientPrimary, borderRadius:BorderRadius.all(Radius.circular(9.81818))),
            height: 28,
            width: 28,
            padding: const EdgeInsets.all(6),
            child: UIIcons.plus(
                color: UIColors.white, size: const Size(9.33, 9.33)),
          ),
        ),
      ),
    );
  }
}
