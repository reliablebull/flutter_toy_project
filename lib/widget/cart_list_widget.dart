import 'package:eat_project/custom/item_counter.dart';
import 'package:eat_project/custom/round_button_order.dart';
import 'package:eat_project/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/s_user.dart';

class CartListWidget extends StatefulWidget {
  CartListWidget({Key? key}) : super(key: key);

  @override
  State<CartListWidget> createState() => _CartListWidgetState();
}

class _CartListWidgetState extends State<CartListWidget> {
  final _valueList = ['세븐일레븐 고대2호점'];

  String? _selectedValue = '세븐일레븐 고대2호점'; // 배달 지역

  @override
  Widget build(BuildContext context) {
    //_selectedValue = SUser.location;
    SUser.location = _selectedValue;
    return Scaffold(
        appBar: AppBar(
          title: Text("장바구니"),
        ),
        body: Provider.of<CartProvider>(context).carts.length == 0
            ? Container(
                child: Center(
                  child: Text("장바구니가 비었습니다."),
                ),
              )
            : _buildContent(context),
        bottomNavigationBar:
            Provider.of<CartProvider>(context).carts.length != 0
                ? Padding(
                    padding: const EdgeInsets.only(
                        bottom: 30.0, left: 20.0, right: 20.0, top: 20.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: RoundButtonOrder(
                        title:
                            '${Provider.of<CartProvider>(context).total} 원 공동 주문하기',
                        cart: Provider.of<CartProvider>(context).carts,
                        store: Provider.of<CartProvider>(context, listen: false)
                            .getStore,
                      ),
                    ),
                  )
                : Container(
                    child: Text(""),
                  ));
  }

  Widget _buildContent(context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              Provider.of<CartProvider>(context, listen: false)
                  .getStore
                  .s_name
                  .toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              softWrap: false,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: Provider.of<CartProvider>(context, listen: true)
                    .carts
                    .length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image(
                                height: 100,
                                width: 100,
                                image: NetworkImage(context
                                    .read<CartProvider>()
                                    .carts[index]
                                    .item!
                                    .posterUrl
                                    .toString()),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 140,
                                          child: Text(
                                            context
                                                .watch<CartProvider>()
                                                .carts[index]
                                                .item!
                                                .p_name
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.close,
                                          ),
                                          onPressed: () => context
                                              .read<CartProvider>()
                                              .removeItem(index),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "${(int.parse(context.read<CartProvider>().carts[index].item!.p_price!) * context.watch<CartProvider>().carts[index].amount!).toString() + '원'}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        ItemCounter(
                                          index: index,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Divider(
            height: 1,
            thickness: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("배달비"),
                Text("0원"),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                alignment: Alignment.topLeft, child: Text("음식물 수령 장소")),
          ),
          Container(
            child: DropdownButton(
                value: _selectedValue,
                items: _valueList.map((String item) {
                  return DropdownMenuItem(
                    child: Text(item.toString()),
                    value: item.toString(),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value.toString();
                  });

                  SUser.location = _selectedValue;
                }),
          )
        ],
      ),
    );
  }
}
