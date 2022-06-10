import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sgmk_test/ui/colors.dart';

import '../icons.dart';

class RouteToAdminButton extends StatelessWidget {
  const RouteToAdminButton({Key? key, required this.onPressed, required this.padding})
      : super(key: key);
  final Function(BuildContext context) onPressed;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding,
        child: SizedBox(
          width: 24,
          height: 24,
          child: CupertinoButton(
            padding: const EdgeInsets.all(4),
            onPressed: ()=> onPressed(context),
            child: GradientMask(
              child: UIIcons.person(color: UIColors.white),
            ),
          ),
        ),
      ),
    );
  }
}
