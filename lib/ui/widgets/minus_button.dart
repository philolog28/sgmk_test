import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sgmk_test/ui/colors.dart';

import '../icons.dart';

class MinusButton extends StatelessWidget {
  const MinusButton({Key? key, required this.onPressed, required this.padding}) : super(key: key);
  final VoidCallback? onPressed;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding,
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            decoration:  BoxDecoration(
                color: UIColors.primaryColor.withOpacity(0.1), borderRadius:const BorderRadius.all(Radius.circular(9.81818))),
            height: 28,
            width: 28,
            padding: const EdgeInsets.all(6),
            child: GradientMask(
              child: UIIcons.minus(
                  color: UIColors.white,),
            ),
          ),
        ),
      ),
    );
  }
}
