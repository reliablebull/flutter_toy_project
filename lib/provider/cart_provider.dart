import 'package:eat_project/models/Movie.dart';
import 'package:eat_project/models/Product.dart';
import 'package:eat_project/models/cart.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Cart> _cart = [];
  List<Cart> get carts => _cart;

  Movie? _currentMovie; // 메장정보
  Movie get getStore => _currentMovie!;

  int get currentAmount => amount;
  int get total => _total;

  int amount = 0;
  int _total = 0;

  setStore(Movie selectStore) {
    _currentMovie = selectStore;

    notifyListeners();
  }

  addCart(Product item) {
    _cart.add(
      Cart(item: item, amount: amount),
    );
    getSum();
    notifyListeners();
  }

  plusAmount() {
    amount++;
    getSum();
    notifyListeners();
  }

  minusAmount() {
    amount--;
    getSum();
    notifyListeners();
  }

  clearCart() {
    _cart.clear();
    _total = 0;
    amount = 1;
    //_currentMovie = null;
    notifyListeners();
  }

  clearAmount() {
    amount = 1;
//    notifyListeners();
  }

  updateAmount(int index, int amount) {
    _cart[index].amount = _cart[index].amount! + amount;
    getSum();
    notifyListeners();
  }

  removeItem(int index) {
    _cart.removeAt(index);
    getSum();
    notifyListeners();
  }

  getSum() {
    _total = 0;
    for (int i = 0; i < _cart.length; i++)
      _total = _total + (_cart[i].amount! * int.parse(_cart[i].item!.p_price!));
    //notifyListeners();
  }
}
