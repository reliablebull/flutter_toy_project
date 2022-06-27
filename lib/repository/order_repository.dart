import 'dart:convert';
import 'package:eat_project/models/Movie.dart';
import 'package:eat_project/models/Order.dart';
import 'package:eat_project/models/Product.dart';
import 'package:eat_project/models/s_user.dart';
import 'package:eat_project/provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:provider/provider.dart';

class OrderRepository {
  Future<List<Order>> loadOrders() async {
    var queryPram = {
      'p_number': SUser.phoneNumber,
    };

    var uri = Uri.http('hajin220.dothome.co.kr', '/get_order.php', queryPram);
    var response = await http.get(uri);

    print(utf8.decode(response.bodyBytes));
    //print(response);
    if (response.body != null) {
      Map<String, dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      if (body["results"] != null) {
        List<dynamic> list = body["results"];
        return list.map<Order>((item) => Order.fromJson(item)).toList();
      }
    } else {
      throw Exception('Failed to load post');
    }

    return [];
  }
}
