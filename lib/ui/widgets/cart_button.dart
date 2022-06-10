import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sgmk_test/ui/colors.dart';

import '../icons.dart';

class CartButton extends StatelessWidget {
  const CartButton({Key? key, required this.onPressed, required this.padding})
      : super(key: key);
  final Function(BuildContext context) onPressed;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding,
        child: SizedBox(
          height: 24,
          width: 24,
          child: CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 1,vertical: 2.49),
            onPressed: ()=> onPressed(context),
            child: GradientMask(
              child: UIIcons.cart(color: UIColors.white),
            ),
          ),
        ),
      ),
    );
  }
}
