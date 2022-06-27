import 'package:eat_project/custom/round_button.dart';
import 'package:eat_project/models/Movie.dart';
import 'package:eat_project/models/Product.dart';
import 'package:eat_project/provider/cart_provider.dart';
import 'package:eat_project/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoreDetailWidget extends StatelessWidget {
  StoreDetailWidget({Key? key}) : super(key: key);

  ProductProvider? _productProvider;
  CartProvider? _cartProvider;

  @override
  Widget build(BuildContext context) {
    final Movie args = ModalRoute.of(context)!.settings.arguments as Movie;

    _productProvider = Provider.of<ProductProvider>(context, listen: false);
    _cartProvider = Provider.of<CartProvider>(context, listen: true);

    _productProvider!.loadProducts(args);

    //List<Product> listProduct = _productProvider!.product;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.black),
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                args.s_name.toString(),
                style: TextStyle(fontSize: 14),
              ),
              background: Image(
                fit: BoxFit.fill,
                image: NetworkImage(args.posterUrl),
              ),
            ),
          ),
          SliverPersistentHeader(
              delegate: CategoryBreacrumb(
                  minPrice: args.s_min_price,
                  tip: args.s_tip,
                  startTime: args.s_start,
                  endTime: args.s_end)),
          //SliverPersistentHeader(delegate: _Sliver)
          Consumer<ProductProvider>(
            builder: ((context, provider, widget) {
              return SliverList(
                // 아이템을 빌드하기 위해서 delegate 항목을 구성함
                // SliverChildBuilderDelegate는 ListView.builder 처럼 리스트의 아이템을 생성해줌
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Card(
                    child: InkWell(
                      onTap: () {
                        //print(index);
                        Navigator.pushNamed(context, '/product_info',
                            arguments: {
                              'product': provider.product[index],
                              'store': args
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image(
                              height: 100,
                              width: 100,
                              image: NetworkImage(
                                provider.product[index].posterUrl.toString(),
                              ),
                              // image: NetworkImage(
                              //   listProduct[index].posterUrl.toString(),
                              //),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(provider.product[index].p_name
                                      .toString()),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    provider.product[index].p_price.toString() +
                                        "원",
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  childCount: provider.product.length,
                ),
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
            bottom: 30.0, left: 20.0, right: 20.0, top: 20.0),
        child: SizedBox(
          width: double.infinity,
          child: RoundButton(
            title:
                '장바구니        ${context.watch<CartProvider>().carts.length} 개',
          ),
        ),
      ),
    );
  }
}

class CategoryBreacrumb extends SliverPersistentHeaderDelegate {
  String? minPrice;
  String? tip;
  String? startTime;
  String? endTime;

  CategoryBreacrumb({this.minPrice, this.tip, this.startTime, this.endTime});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
      height: 100,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("최소주문금액 | " + minPrice.toString() + " 원"),
                  Text("배달팁 | " + tip.toString() + "원"),
                  Text("영업시간 | " +
                      startTime.toString() +
                      " ~ " +
                      endTime.toString()),
                ]),
          ),
          Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 100;

  @override
  // TODO: implement minExtent
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
