import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sgmk_test/ui/icons.dart';
import 'package:sgmk_test/ui/styles.dart';
import 'package:sgmk_test/ui/widgets/counter.dart';

import '../colors.dart';

class PizzaContainerAdmin extends StatelessWidget {
  const PizzaContainerAdmin(
      {Key? key,
      required this.title,
      required this.price,
      required this.maxQuantity,
      required this.onChangedTitle,
      required this.onChangedPrice,
      required this.decrement,
      required this.increment})
      : super(key: key);
  final String? title;
  final double? price;
  final int? maxQuantity;
  final Function(String? text) onChangedTitle;
  final Function(String? text) onChangedPrice;
  final Function(int? maxQuantity) decrement;
  final Function(int? maxQuantity) increment;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 218,
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
                  left: 17.5, top: 71.5, bottom: 71.5, right: 20),
              child: SizedBox(
                  width:  MediaQuery.of(context).size.width * 0.135,
                  height:  MediaQuery.of(context).size.width * 0.135,
                  child: Image.asset(
                    'assets/images/pizza.png',
                  )),
            ),
            Column(mainAxisSize: MainAxisSize.min, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'Name',
                  style: UIStyles.w600s18(),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.23,
                  child: titleTextFields(
                      title, onChangedTitle, TextInputType.name, context),
                ),
              ]),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: UIStyles.w600s18(),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.23,
                    child: titleTextFields(price!.toStringAsFixed(0),
                        onChangedPrice, TextInputType.number, context),
                  ),
                ],
              ),
            ]),
          ]),
          Counter(
              quantity: maxQuantity,
              decrement: decrement,
              increment: increment),
        ],
      ),
    );
  }

  titleTextFields(String? initialText, Function(String? text) onChanged,
      TextInputType type, BuildContext context) {
    late final TextEditingController controller =
        TextEditingController(text: initialText);
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
    return SizedBox(
      height: 32,
      child: TextField(
        cursorColor: UIColors.coursorColor,
        keyboardType: type,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 8, bottom: 8, left: 12),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: UIColors.border)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: UIColors.border)),
          suffixIcon: SizedBox(
            height: 14,
            width: 14,
            child: CupertinoButton(
              onPressed: () {
                controller.clear();
                onChanged(controller.text);
              },
              padding: const EdgeInsets.all(1),
              child: UIIcons.clear(color: UIColors.black),
            ),
          ),
        ),
      ),
    );
  }
}
