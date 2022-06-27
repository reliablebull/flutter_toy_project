import 'dart:convert';
import 'package:eat_project/models/Movie.dart';
import 'package:eat_project/models/Product.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;

class ProductRepository {
  Future<List<Product>> loadProducts(Movie movie) async {
    var queryPram = {
      's_id': movie.s_id,
    };

    var uri = Uri.http('hajin220.dothome.co.kr', '/get_product.php', queryPram);
    var response = await http.get(uri);

    print(utf8.decode(response.bodyBytes));
    //print(response);
    if (response.body != null) {
      Map<String, dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      if (body["results"] != null) {
        List<dynamic> list = body["results"];
        return list.map<Product>((item) => Product.fromJson(item)).toList();
      }
    } else {
      throw Exception('Failed to load post');
    }

    return [];
  }

  // 주문 넣ㅣ
  insertOrder() {}
}
