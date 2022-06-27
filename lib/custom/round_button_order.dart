import 'dart:convert';

import 'package:eat_project/models/Movie.dart';
import 'package:eat_project/models/cart.dart';
import 'package:eat_project/models/s_user.dart';
import 'package:eat_project/provider/bottom_navigation_provider.dart';
import 'package:eat_project/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './constants.dart';
import 'package:http/http.dart' as http;

// 장바구니 주문하기 버튼
class RoundButtonOrder extends StatelessWidget {
  final String? title;
  final List<Cart>? cart;
  final Movie? store;
  final String? total;

  RoundButtonOrder({Key? key, this.title, this.cart, this.store, this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        insertOrder(context);

        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  content: const Text("공동 주문이 접수되었습니다."),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Provider.of<BottomNavigationProvider>(context,
                                  listen: false)
                              .updateCurrentPage(1);

                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/main',
                            (Route<dynamic> route) => false,
                          );
                          // Navigator.of(context).pop();

                          // Navigator.pushNamed(
                          //   context,
                          //   '/main',
                          // );
                        },
                        child: const Text("확인")),
                  ],
                ));
      },
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          title.toString(),
          style: kTitleStyle.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  insertOrder(context) async {
    String tmp = "";

    for (int i = 0; i < cart!.length; i++) {
      tmp += cart![i].item!.p_name.toString() +
          ":" +
          cart![i].amount.toString() +
          ";";
    }

    print(tmp);
    var queryPram = {
      's_id': store!.s_id.toString(),
      'o_list': tmp,
      'o_location': SUser.location,
      'o_total':
          Provider.of<CartProvider>(context, listen: false).total.toString(),
      'o_phone_number': SUser.phoneNumber,
      'o_status': '1'
    };

    var uri =
        Uri.http('hajin220.dothome.co.kr', '/insert_order.php', queryPram);
    var response = await http.get(uri);

    Provider.of<CartProvider>(context, listen: false).clearCart();
  }
}
