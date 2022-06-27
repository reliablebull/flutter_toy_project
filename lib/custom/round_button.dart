import 'package:eat_project/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RoundButton extends StatelessWidget {
  final String? title;
  final Function? onTouch;

  const RoundButton({
    Key? key,
    this.title,
    this.onTouch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // if (Provider.of<CartProvider>(context, listen: false).carts.length <
        //     1) {
        //   showToast("test");
        // } else {
        //   Navigator.pushNamed(
        //     context,
        //     '/cart_list',
        //   );
        // }

        Navigator.pushNamed(
          context,
          '/cart_list',
        );
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

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: '장바구니가 비었습니다', // 토스트 메시지 내용
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.grey, // 배경색 빨강색
        fontSize: 20.0,
        textColor: Colors.white, // 폰트 하얀색
        toastLength: Toast.LENGTH_LONG // 토스트 메시지 지속시간 짧게
        );
  }
}
