

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sgmk_test/ui/styles.dart';

import '../colors.dart';

class PizzaContainerCatalog extends StatelessWidget {
  const PizzaContainerCatalog({
    Key? key,
    required this.title,
    required this.price,required this.onTap,
  }) : super(key: key);
  final String? title;
  final double? price;
  final Function(BuildContext context) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> onTap(context),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            color: UIColors.white,
            boxShadow: [
              BoxShadow(
                  color: UIColors.shadowsColor.withOpacity(0.08),
                  offset: const Offset(
                    12,
                    26,
                  ),
                  blurRadius: 50,
                  spreadRadius: 0)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 20, bottom: 12, top: 12),
                child: SizedBox(
                    width: 64,
                    height: 64,
                    child: Image.asset(
                      'assets/images/pizza.png',
                      fit: BoxFit.fill,
                    )),
              ),
              ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.4),
              child: Text('$title', style: UIStyles.w600s18(),overflow: TextOverflow.clip,)),
            ]),
            Padding(
              padding: const EdgeInsets.only(right: 32, top: 22, bottom: 22),
              child: Text('\$${price!.toStringAsFixed(0)}',
                  style: UIStyles.w600s29Primary()),
            ),
          ],
        ),
      ),
    );
  }
}
