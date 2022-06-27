import 'package:eat_project/db/database_helper.dart';
import 'package:eat_project/models/Grocery.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class CheckLogin extends StatefulWidget {
  const CheckLogin({Key? key}) : super(key: key);

  @override
  State<CheckLogin> createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  @override
  Widget build(BuildContext context) {
    // FutureBuilder<List<Grocery>>(
    //   builder: (context, snapshot) {
    //     print(snapshot.hasData);
    //   },
    // );
    final db = DatabaseHelper.instance.getGroceries();

    return Container(
      child: Text("123"),
    );
  }

  @override
  void initState() {
    super.initState();

    // DatabaseHelper.instance.getGroceries().then((value) {
    //   print(value.length);
    // });
  }
}
