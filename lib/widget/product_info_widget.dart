import 'package:eat_project/custom/conter.dart';
import 'package:eat_project/models/Movie.dart';
import 'package:eat_project/models/Product.dart';
import 'package:eat_project/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 선택된 제품 전달
    final args2 = ModalRoute.of(context)!.settings.arguments as Map;

    final Product args = args2['product'] as Product;
    final Movie store = args2['store'] as Movie;
    CartProvider? cartProvider;

    print(args.p_name);
    cartProvider = Provider.of<CartProvider>(context, listen: false);
    context.read<CartProvider>().clearAmount();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(store.s_name.toString()),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Hero(
                        tag: '1',
                        child: Image.network(
                          args.posterUrl.toString(),
                          width: MediaQuery.of(context).size.width * .7,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "${args.p_name}",
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Text(
                      "가격",
                    ),
                    Text(
                      "${args.p_price}",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Counter(args),
                        // Text(
                        //     //"${int.parse(args.p_price.toString()) * context.watch<CartProvider>().total}",
                        //     "${context.read<CartProvider>().amount}"),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                        child: Text(
                          "담기",
                        ),
                        onPressed: () {
                          context.read<CartProvider>().setStore(store);
                          context.read<CartProvider>().addCart(args);
                          Navigator.pop(context);
                        },
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
