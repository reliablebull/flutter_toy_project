import 'package:eat_project/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemCounter extends StatefulWidget {
  int? index = -1;

  ItemCounter({this.index});
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<ItemCounter> {
  CartProvider? cartProvider;

  @override
  Widget build(BuildContext context) {
    //widget.index;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            // setState(() {
            //   _count += 1;
            // });

            context.read<CartProvider>().updateAmount(widget.index!, 1);
          },
          child: Container(
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(),
            ),
            child: Icon(Icons.add),
          ),
        ),
        SizedBox(width: 15.0),
        Text("${context.watch<CartProvider>().carts[widget.index!].amount}"),
        SizedBox(width: 15.0),
        GestureDetector(
          onTap: () {
            context.read<CartProvider>().updateAmount(widget.index!, -1);
            //context.read<CartProvider>().minusAmount();
          },
          child: Container(
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(),
            ),
            child: Icon(Icons.remove),
          ),
        ),
      ],
    );
  }
}
