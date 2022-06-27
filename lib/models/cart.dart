import 'dart:convert';

import 'package:eat_project/models/Product.dart';

class Cart {
  Product? item;
  int? amount;

  Cart({
    this.item,
    this.amount,
  });
}
