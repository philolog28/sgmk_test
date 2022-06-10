

import 'package:flutter/material.dart';
import 'package:sgmk_test/ui/styles.dart';
import 'package:sgmk_test/ui/widgets/plus_button.dart';

import 'minus_button.dart';

class Counter extends StatefulWidget {
   Counter(
      {Key? key, required this.quantity, required this.decrement, required this.increment})
      : super(key: key);
   int? quantity;
  final Function(int? q) decrement;
  final Function(int? q) increment;

  @override
  State<Counter> createState() => _CounterState();
}
class _CounterState extends State<Counter> {
  @override

  @override
  Widget build(BuildContext context) {
     TextEditingController controller = TextEditingController(text: '${widget.quantity}');
    return Row(
      children: [
        MinusButton(onPressed: () => setState(() {
          widget.decrement(widget.quantity!-1);
        }),
          padding: const EdgeInsets.only(left: 18.5, right: 12),),
        IntrinsicWidth(
          child: TextField(
            maxLength: 2,
            style: UIStyles.w600s16(),
            controller: controller,
            readOnly:  true,
            decoration: const InputDecoration(
                border: InputBorder.none,
              counterText: '',
            ),
          ),
        ),
        PlusButton(onPressed: () {
          if(widget.quantity!<99){
              widget.increment(widget.quantity! + 1);
            }
          },
          padding: const EdgeInsets.only(left: 12, right: 32),),
      ],
    );
  }
}
