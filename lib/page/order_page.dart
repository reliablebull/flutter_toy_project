import 'package:eat_project/models/s_user.dart';
import 'package:eat_project/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<IconData> _icon = [
    Icons.refresh,
    Icons.check,
    Icons.cancel,
  ];

  List<String> comment = [
    '주문 접수 대기중', // 1
    '주문이 접수되었습니다. 입금을 완료해주세요', // 2
    '배달중입니다. 픽업장소 도착시 알려드릴게요', // 3
    '배달완료. 얼른 픽업해 주세요', // 4
    '취소 완료' // 5
  ];

  OrderProvider? _orderProvider;

  @override
  Widget build(BuildContext context) {
    _orderProvider = Provider.of<OrderProvider>(context, listen: false);
    if (SUser.flag == 0) testFunction(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // disable button
        title: Text("주문현황"),
      ),
      body: _buildContent(context),
    );
  }

  Future<void> testFunction(context) async {
    print(">>> start test");
    SUser.flag = 1;
    int sec = 0;
    await Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      sec += 5;
      // if (sec >= 60) {
      //   print("> end doWhile after 60 seconds");
      //   return false;
      // }

      print(sec);

      if (SUser.flag == 1) {
//Provider.of<OrderProvider>(context!, listen: false).loadOrders();

        _orderProvider!.loadOrders();
      } else
        return false;

      print("> elapsed $sec seconds");
      print(SUser.flag);

      return true;
    }).timeout(Duration(seconds: 20)).then(print).catchError(print);

    print(">>> end test");
  }

  _buildContent(context) {
    Provider.of<OrderProvider>(context, listen: false).loadOrders();
    return Column(
      children: [
        Container(
          child: Expanded(
            child: Consumer<OrderProvider>(
              builder: ((context, provider, child) {
                return ListView.builder(
                    itemCount: provider.orders.length,
                    // Provider.of<OrderProvider>(context, listen: false)
                    //     .orders
                    //     .length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 30, right: 30, left: 30),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(context
                                          .watch<OrderProvider>()
                                          .orders[index]
                                          .posterUrl
                                          .toString())),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 250,
                                  child: Text(
                                    Provider.of<OrderProvider>(context,
                                            listen: false)
                                        .orders[index]
                                        .s_name
                                        .toString(),
                                    style: TextStyle(fontSize: 25),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "주문내역",
                                  style: TextStyle(color: Colors.grey),
                                )),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Provider.of<OrderProvider>(context,
                                        listen: false)
                                    .orders[index]
                                    .o_list
                                    .toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Divider(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "결제 예정 금액",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Provider.of<OrderProvider>(context,
                                            listen: false)
                                        .orders[index]
                                        .o_total
                                        .toString() +
                                    "원",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Divider(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "픽업 장소",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Provider.of<OrderProvider>(context,
                                        listen: false)
                                    .orders[index]
                                    .o_location
                                    .toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 40,
                              child: Center(
                                child: Row(
                                  children: [
                                    if (int.parse(Provider.of<OrderProvider>(
                                                context,
                                                listen: false)
                                            .orders[index]
                                            .o_status
                                            .toString()) <
                                        4) ...[
                                      Icon(Icons.refresh),
                                    ] else if (int.parse(
                                            Provider.of<OrderProvider>(context,
                                                    listen: false)
                                                .orders[index]
                                                .o_status
                                                .toString()) ==
                                        4) ...[
                                      Icon(Icons.check),
                                    ] else ...[
                                      Icon(Icons.cancel),
                                    ],
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      comment[int.parse(
                                              Provider.of<OrderProvider>(
                                                      context,
                                                      listen: false)
                                                  .orders[index]
                                                  .o_status
                                                  .toString()) -
                                          1],
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              color: Colors.green.withOpacity(0.4),
                            ),
                            if (int.parse(Provider.of<OrderProvider>(context,
                                        listen: false)
                                    .orders[index]
                                    .o_status
                                    .toString()) ==
                                2) ...[
                              Text("카카오뱅크(정하진) 3333-09-8627414"),
                            ] else
                              ...[],
                            Divider()
                          ],
                        ),
                      );
                    });
              }),
            ),
          ),
        ),
      ],
    );
  }
}
