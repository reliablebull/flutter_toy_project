import 'package:eat_project/models/s_user.dart';
import 'package:eat_project/page/home_page.dart';
import 'package:eat_project/page/my_page.dart';
import 'package:eat_project/provider/bottom_navigation_provider.dart';
import 'package:eat_project/page/order_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  BottomNavigationProvider? _bottomNavigationProvider;

  @override
  Widget build(BuildContext context) {
    SUser.flag = 0;
    _bottomNavigationProvider = Provider.of<BottomNavigationProvider>(context);
    return Scaffold(
      body: _navigationBody(),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }

  Widget _bottomNavigationBarWidget() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: '주문현황'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: '마이페이지'),
      ],
      currentIndex: _bottomNavigationProvider!.currentPage,
      selectedItemColor: Colors.red,
      onTap: (index) {
        _bottomNavigationProvider!.updateCurrentPage(index);
      },
    );
  }

  Widget _navigationBody() {
    switch (_bottomNavigationProvider!.currentPage) {
      case 0:
        return HomePage();
        break;
      case 1:
        return OrderPage();
        break;
      case 2:
        return MyPage();
        break;
    }
    return Container();
  }
}

// class MainPage extends StatefulWidget {
//   const MainPage({Key? key}) : super(key: key);

//   @override
//   _MainPageState createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   int _selectedIndex = 0;
//   List<Widget> _widgetOptions = [
//     Text('home'),
//     Text('order'),
//     Text('mypage'),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('잇때다'),
//       ),
//       body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//               // 현재 아이콘이 선택된 아이콘일때와 선택된 아이콘이 아닌 경우 Icon을 다르게 하기 위함
//               icon: _selectedIndex == 0
//                   ? Icon(
//                       Icons.home_filled,
//                       color: Colors.black,
//                     )
//                   : Icon(Icons.home_outlined, color: Colors.black),
//               label: '홈'),
//           BottomNavigationBarItem(
//               icon: _selectedIndex == 1
//                   ? Icon(
//                       Icons.shopping_bag,
//                       color: Colors.black,
//                     )
//                   : Icon(
//                       Icons.shopping_bag_outlined,
//                       color: Colors.black,
//                     ),
//               label: '주문현황'),
//           BottomNavigationBarItem(
//               icon: _selectedIndex == 2
//                   ? Icon(
//                       Icons.people,
//                       color: Colors.black,
//                     )
//                   : Icon(Icons.people_outlined, color: Colors.black),
//               label: '마이페이지'),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.black,
//         onTap: _onItemTapped,
//         showSelectedLabels: true, //(1)
//         showUnselectedLabels: true, //(1)
//         type: BottomNavigationBarType.fixed, //(2)
//       ),
//     );
//   }

//   Widget _bottomNavigationBarWidget() {
//     return BottomNavigationBar(
//       items: [
//         BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//         BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movie'),
//       ],
//       currentIndex: _bottomNavigationProvider!.currentPage,
//       selectedItemColor: Colors.red,
//       onTap: (index) {
//         _bottomNavigationProvider!.updateCurrentPage(index);
//       },
//     );
//   }
// }
