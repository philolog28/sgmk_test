import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../colors.dart';
class CustomLoadingIndicator{
  static void initEasyMask() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 5
      ..progressColor = UIColors.primaryColor
      ..backgroundColor = UIColors.scaffoldColor
      ..indicatorColor = Colors.black
      ..textColor = Colors.blue
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false
      ..customAnimation = CustomAnimation();
  }

  static get startLoading => EasyLoading.show(
    maskType: EasyLoadingMaskType.black,
  );

  static get stopLoading => EasyLoading.dismiss();

}

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
      Widget child,
      AnimationController controller,
      AlignmentGeometry alignment,
      ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}
