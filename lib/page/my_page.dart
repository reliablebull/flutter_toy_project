import 'package:eat_project/db/database_helper.dart';
import 'package:eat_project/models/s_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  Widget _buildContent(context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(SUser.name.toString()),
          SizedBox(
            height: 10,
          ),
          Text(SUser.phoneNumber.toString()),
          Divider(
            height: 10.0,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("고객센터"),
              Text("010-2046-2450\n010-9402-0205"),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 10.0,
          ),
          GestureDetector(
              onTap: () {
                DatabaseHelper.instance.remove();

                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/',
                  (Route<dynamic> route) => false,
                );
              },
              child: Text("로그아웃")),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("버전"),
              Text("v2.1"),
            ],
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SUser.flag = 0;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // disable button
        title: Text("마이페이지"),
      ),
      body: _buildContent(context),
    );
  }
}
