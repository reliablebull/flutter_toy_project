import 'package:eat_project/db/database_helper.dart';
import 'package:eat_project/models/Grocery.dart';
import 'package:eat_project/models/s_user.dart';
import 'package:eat_project/page/login_page.dart';
import 'package:eat_project/page/main_page.dart';
import 'package:eat_project/provider/bottom_navigation_provider.dart';
import 'package:eat_project/provider/cart_provider.dart';
import 'package:eat_project/provider/movie_provider.dart';
import 'package:eat_project/provider/order_provider.dart';
import 'package:eat_project/provider/product_provider.dart';
import 'package:eat_project/provider/user_provider.dart';
import 'package:eat_project/widget/cart_list_widget.dart';
import 'package:eat_project/widget/product_info_widget.dart';
import 'package:eat_project/widget/store_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'page/check_login.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _flag = false;
  var app;

  // Future<void> check() async {
  //   await DatabaseHelper.instance.getGroceries().then((value) {
  //     //print(value.isEmpty);
  //     if (!value.isEmpty) {
  //       SUser.name = value[0].name.toString();
  //       SUser.phoneNumber = value[0].id.toString();
  //       this._flag = true;
  //       print("test" + _flag.toString());
  //       //print("!@#!@#@!#!@#!@");
  //     }
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  // Future.delayed(Duration.zero, () async {
  //   //String var1 = await testfunction();
  //   //here is the async code, you can execute any async code here
  //   //print(var1);

  //   List<Grocery> t = await DatabaseHelper.instance.getGroceries();

  //   print("!@#");
  //   // await DatabaseHelper.instance.getGroceries().then((value) {
  //   //   //print(value.isEmpty);
  //   //   if (!value.isEmpty) {
  //   //     SUser.name = value[0].name.toString();
  //   //     SUser.phoneNumber = value[0].id.toString();
  //   //     this._flag = true;
  //   //     print("test" + _flag.toString());
  //   //     //print("!@#!@#@!#!@#!@");
  //   //   }
  //   // });
  // });

  //   // check();
  //   app = MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Flutter Demo',
  //     theme: ThemeData(
  //       primarySwatch: Colors.blue,
  //     ),
  //     initialRoute: _flag == true ? '/main' : '/login',
  //     routes: {
  //       '/': (context) => CheckLogin(),
  //       '/login': (context) => LoginPage(),
  //       '/main': (context) => MainPage(),
  //       '/deatil_product': (context) => StoreDetailWidget(),
  //       '/product_info': (context) => ProductInfo(),
  //       '/cart_list': (context) => CartListWidget(),
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    //WidgetsFlutterBinding.ensureInitialized();
    final database = DatabaseHelper.instance.database;

    //List<Grocery> grocery = database.getGroceries() as List<Grocery>;
    // print("test");

    // print('qqq');
    // print(_flag);
    // print('ttt');

    // var app = MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   initialRoute: _flag == true ? '/main' : '/login',
    //   routes: {
    //     '/': (context) => CheckLogin(),
    //     '/login': (context) => LoginPage(),
    //     '/main': (context) => MainPage(),
    //     '/deatil_product': (context) => StoreDetailWidget(),
    //     '/product_info': (context) => ProductInfo(),
    //     '/cart_list': (context) => CartListWidget(),
    //   },
    // );

    //_flag = false;

    print("build" + _flag.toString());
    return FutureBuilder<List<Grocery>>(
      //future: DatabaseHelper.instance.getGroceries(),
      future: DatabaseHelper.instance.getGroceries(),
      builder: ((context, AsyncSnapshot<List<Grocery>> snapshot) {
        //SharedPreferences prefs = SharedPreferences.getInstance();
        print(snapshot.hasData);

        if (snapshot.hasData) {
          if (snapshot.data!.length != 0) {
            SUser.name = snapshot.data![0].name;
            SUser.phoneNumber = snapshot.data![0].id;
          }

          print(snapshot.data!.length.toString());
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (BuildContext context) => BottomNavigationProvider(),
              ),
              ChangeNotifierProvider(
                  create: (BuildContext context) => MovieProvider()),
              ChangeNotifierProvider(
                  create: (BuildContext context) => ProductProvider()),
              ChangeNotifierProvider(
                  create: (BuildContext context) => CartProvider()),
              ChangeNotifierProvider(
                  create: (BuildContext context) => OrderProvider()),
              ChangeNotifierProvider(
                  create: (BuildContext context) => UserProvider()),
            ],
            child: ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: () => MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                initialRoute: snapshot.data!.length != 0 ? '/main' : '/',
                routes: {
                  //'/': (context) => CheckLogin(),
                  '/': (context) => LoginPage(),
                  '/main': (context) => MainPage(),
                  '/deatil_product': (context) => StoreDetailWidget(),
                  '/product_info': (context) => ProductInfo(),
                  '/cart_list': (context) => CartListWidget(),
                },
              ),
            ),
          );
        } else
          return Center();
      }),
    );
  }
}

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     var app = MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => LoginPage(),
//         '/main': (context) => MainPage(),
//       },
//     );
//   }
// }

// class MyHome extends StatelessWidget {
//   const MyHome({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
