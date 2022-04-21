import 'dart:convert';

import '../constants/url.dart';
import '../database/db_provider.dart';
import '../models/product_detail_model.dart';
import 'package:http/http.dart' as http;

class getProductDetailProvider {
  final url = AppUrl.baserUrl;

  Future<ProductDetail> getProductDetail(String id) async {
    final token = await DatabaseProvider().getToken();

    String _url = '$url/api/v1/product/get/$id';

    try {
      final request = await http.get(
          Uri.parse(_url), headers: {'access-token':'$token'});
      print(" !!!!!!!  $token ");
      print(request.statusCode);
      if (request.statusCode == 200) {
        print(request.body);
        var data = jsonDecode(request.body.toString());
        if (json.decode( request.body)["product"] == null) {
          return ProductDetail();
        }  else {
          return ProductDetail.fromJson(data);
        }
      } else {
        print(request.body);
        return ProductDetail();
      }
    } catch (e) {
      print(e);
      return Future.error(e.toString());
    }
  }



}