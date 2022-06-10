import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sgmk_test/ui/styles.dart';
import 'package:sgmk_test/ui/widgets/counter.dart';

import '../colors.dart';

class PizzaContainerCart extends StatelessWidget {
  const PizzaContainerCart({
    Key? key,
    required this.title,
    required this.price,required this.quantity, required this.decrement, required this.increment,
  }) : super(key: key);
  final String? title;
  final double? price;
  final int? quantity;
  final Function(int? quantity) decrement;
  final Function(int? quantity) increment;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  width: 75,
                  height: 75,
                  child: Image.asset(
                    'assets/images/pizza.png',
                    fit: BoxFit.fill,
                  )),
            ),
            ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('$title', style: UIStyles.w600s18(),overflow: TextOverflow.clip,),
                    Text('\$${price!.toStringAsFixed(0)}',
                        style: UIStyles.w600s18Primary()),
                  ],
                )),

          ]),
          Counter(quantity:quantity , decrement: decrement, increment:increment ),
        ],
      ),
    );
  }
}
