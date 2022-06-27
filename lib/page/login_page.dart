import 'package:eat_project/db/database_helper.dart';
import 'package:eat_project/models/Grocery.dart';
import 'package:eat_project/models/s_user.dart';
import 'package:eat_project/models/user.dart';
import 'package:eat_project/provider/user_provider.dart';
import 'package:eat_project/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final UserRepository userRepository = UserRepository();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? u_name;
  String? u_number;
  @override
  Widget build(BuildContext context) {
    DatabaseHelper.instance.database;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildBody(context),
        ],
      ),
    );
  }

  bool _isValidPhone(String val) {
    return RegExp(r'^010\d{7,8}$').hasMatch(val);
  }

  _buildBody(context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                "잇(EAT) 때다",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                onChanged: ((value) => {u_name = value}),
                decoration: InputDecoration(
                  labelText: '닉네임 입력',
                  border: OutlineInputBorder(),
                ),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              // Container(height: 10,),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: ((value) {
                  u_number = value;

                  //_isValidPhone(u_number ?? '');
                }),
                decoration: InputDecoration(
                  labelText: '휴대폰번호 입력',
                  hintText: '01012341234',
                  border: OutlineInputBorder(),
                ),
                // validator: (String? val) {
                //   return _isValidPhone(val ?? '')
                //       ? null
                //       : '올바른 휴대폰 번호를 입력 해 주세요';
                // },
                controller: passwordController,
                obscureText: true,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.maxFinite,
                child: RaisedButton(
                  onPressed: () async {
                    // Navigator.pushNamed(context, '/product_info', arguments: {
                    //   'product': listProduct[index],
                    //   'store': args
                    // });

                    if (_isValidPhone(u_number ?? '') == false) {
                      showToast('');
                      return;
                    }
                    userRepository.insertUser(
                        u_number.toString(), u_name.toString());
                    SUser.name = u_name;
                    SUser.phoneNumber = u_number;
                    //Provider.of<UserProvider>(context, listen: false)
                    //    .insertUser(User(name: u_name, phoneNumber: u_number));
                    await DatabaseHelper.instance.add(
                      Grocery(
                          name: SUser.name.toString(),
                          id: SUser.phoneNumber.toString()),
                    );

                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/main', (Route<dynamic> route) => false,
                        arguments: {'name': u_name, 'number': u_number});
                    // Navigator.pushNamed(context, '/main',
                    //     arguments: {'name': u_name, 'number': u_number});
                  },
                  child: Text('입장하기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: '올바른 핸드폰 번호를 입력하세요', // 토스트 메시지 내용
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.grey, // 배경색 빨강색
        fontSize: 12.0,
        textColor: Colors.white, // 폰트 하얀색
        toastLength: Toast.LENGTH_LONG // 토스트 메시지 지속시간 짧게
        );
  }
}
