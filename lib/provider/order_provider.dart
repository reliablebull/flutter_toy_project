import 'package:eat_project/models/Movie.dart';
import 'package:eat_project/models/Order.dart';
import 'package:eat_project/repository/order_repository.dart';
import 'package:flutter/material.dart';
import '../repository/movie_repository.dart';

class OrderProvider extends ChangeNotifier {
  OrderRepository _orderRepository = OrderRepository();

  List<Order> _orders = [];
  List<Order> get orders => _orders;

  loadOrders() async {
    List<Order> listOrders = await _orderRepository.loadOrders();
    if (listOrders != []) _orders = listOrders;
    //_movieRepository.test();
    notifyListeners();
  }
}
