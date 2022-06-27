import 'package:eat_project/models/Movie.dart';
import 'package:eat_project/models/Product.dart';
import 'package:eat_project/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter extends StatefulWidget {
  Product? currentProduct;

  Counter(this.currentProduct);
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  CartProvider? cartProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  // setState(() {
                  //   _count += 1;
                  // });
                  context.read<CartProvider>().plusAmount();
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
              Text("${context.watch<CartProvider>().amount}"),
              SizedBox(width: 15.0),
              GestureDetector(
                onTap: () {
                  context.read<CartProvider>().minusAmount();
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
          ),
          Text(
              "${int.parse(widget.currentProduct!.p_price.toString()) * context.watch<CartProvider>().amount}"),
          //Text("${context.watch<CartProvider>().total}"),
        ],
      ),
    );
  }
}
