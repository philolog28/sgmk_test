import 'package:flutter/cupertino.dart';
import 'package:sgmk_test/ui/colors.dart';

import '../icons.dart';

class LeadingArrowButton extends StatelessWidget {
  const LeadingArrowButton({Key? key, required this.onPressed}) : super(key: key);
  final Function(BuildContext context) onPressed;

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        height: 36,
        padding:const  EdgeInsets.symmetric(horizontal: 24),
        child: CupertinoButton(
          padding: const EdgeInsets.all(8.18),
          color: UIColors.primaryColor.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(9.81818)),
          onPressed: ()=> onPressed(context) ,
          child: UIIcons.arrowBack(color: UIColors.primaryColor.withOpacity(0.7)),
        ),
      ),
    );
  }
}
