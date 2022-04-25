import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shop_app/constants/url.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/database/db_provider.dart';

class getLikeProvider extends ChangeNotifier{
  //base Url
  final requestBaseUrl = AppUrl.baserUrl;


  //Setter
  bool _isLoadiing = false ;
  String _resMessage = '' ;

  //Getter
  bool get isLoading => _isLoadiing;
  String get resMessage => _resMessage;


  Future like({
    required String id,
    BuildContext? context,
  }) async {
    final token = await DatabaseProvider().getToken();
    _isLoadiing = true;
    notifyListeners();

    String url = '$requestBaseUrl/api/v1/product/like';

    final body = {
      "productdId": id,

    };
    print(body);

    try {
      http.Response req = await http.post(
          Uri.parse(url), body: ( {
        "productId": id,
      }),
          headers: {'access-token':'$token'}
      );

      if (req.statusCode == 200) {
        final body = json.decode(req.body);
        print(body);
        print("Status like: " + body["status"]);
        _isLoadiing = false;
        _resMessage = "Liked successfull";
        notifyListeners();
      } else {
        final res = json.decode(req.body);
        _resMessage = res ["message"];

        print(res);
      }
    } on SocketException catch (_) {
      _isLoadiing = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
    } catch (e) {
      _isLoadiing = false;
      _resMessage = "Please try again";
      notifyListeners();
      print("!!!!  ${e} !!!!!!");
    }
  }



  Future unlike({
    required String id,
    BuildContext? context,
  }) async {
    final token = await DatabaseProvider().getToken();
    _isLoadiing = true;
    notifyListeners();

    String url = '$requestBaseUrl/api/v1/product/unlike';

    final body = {
      "productdId": id,

    };
    print(body);

    try {
      http.Response req = await http.post(
          Uri.parse(url), body: ( {
        "productId": id,
      }),
          headers: {'access-token':'$token'}
      );

      if (req.statusCode == 200) {
        final body = json.decode(req.body);
        print(body);
        print("Status unlike: " + body["status"]);
        _isLoadiing = false;
        _resMessage = "Unliked successfull";
        notifyListeners();
      } else {
        final res = json.decode(req.body);
        _resMessage = res ["message"];

        print(res);
      }
    } on SocketException catch (_) {
      _isLoadiing = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
    } catch (e) {
      _isLoadiing = false;
      _resMessage = "Please try again";
      notifyListeners();
      print("!!!!  ${e} !!!!!!");
    }
  }
}