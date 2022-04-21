import 'dart:convert';

import 'package:shop_app/constants/url.dart';
import 'package:shop_app/database/db_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/product_model.dart';

class getProductProvider {
  final url = AppUrl.baserUrl;

  Future<Product> getProduct() async {
    final token = await DatabaseProvider().getToken();

    String _url = '$url/api/v1/product/all';

    try {
      final request = await http.get(
          Uri.parse(_url), headers: {'access-token':'$token'});
      print(" !!!!!!!  $token ");
      print(request.statusCode);
      if (request.statusCode == 200) {
        print(request.body);
        var data = jsonDecode(request.body.toString());
        if (json.decode( request.body)["products"] == null) {
          return Product();
        }  else {
          return Product.fromJson(data);
        }
      } else {
        print(request.body);
        return Product();
      }
    } catch (e) {
      print(e);
      return Future.error(e.toString());
    }
  }
}