import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class Product {
  final id;
  final String name;
  final String imageUrl;
  final String bigImageUrl;
  final int categoryid;
  final String productPrice;
  final String date;
  final int isNewArrival;
  final int status;
  Product(this.id, this.name, this.imageUrl, this.bigImageUrl, this.categoryid,
      this.productPrice, this.date, this.isNewArrival, this.status);
}

class Products {
  final int id;
  final String name;
  final String imageUri;
  Products(this.id, this.name, this.imageUri);
}

class CartProduct {
  final Product product;
  var quantity;
  void changequantity(var val) {
    quantity = val;
  }

  CartProduct(this.product, this.quantity);
}

class ProductProvider with ChangeNotifier {
  List<CartProduct> _cartlist = [];
  List<Products> _tiles = [];
  List<Products> _mosaic = [];

  get mosaic => _mosaic;
  get tiles => _tiles;
  get cartlist => _cartlist;

  void addtocart(final Product product, final String session) {
    _cartlist.add(CartProduct(product, 1));
    notifyListeners();
  }

  void removefromcart(var id) {
    _cartlist.removeWhere((element) => element.product.id == id);
    notifyListeners();
  }

  void changequantity(var id, var val) {
    print('hello');
    var index = _cartlist.indexWhere((element) => element.product.id == id);
    _cartlist[index].changequantity(val);
  }

  Future<List<Products>> obtaintiles(final String session) async {
    try {
      if (_tiles.length == 0) {
        final url =
            'http://dvj-design.com/api_dvj/Serv_v1/tile?session=$session';
        final response = await http.get(url);
        final jresponse = json.decode(response.body) as Map;
        if (jresponse['status'] == 'failed') throw (jresponse['message']);
        final tilelist = jresponse['data']['category'];
        tilelist.forEach((element) {
          _tiles.add(Products(
              int.parse(element['category_id']),
              element['category_name'].replaceAll('+', ' '),
              Uri.decodeFull(element['category_image'])));
        });
        print(_tiles);
        return _tiles;
      } else
        return _tiles;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Products>> obtainmosaic(final String session) async {
    try {
      if (_mosaic.length == 0) {
        final url =
            'http://dvj-design.com/api_dvj/Serv_v1/mosaic?session=$session';
        final response = await http.get(url);
        final jresponse = json.decode(response.body) as Map;
        if (jresponse['status'] == 'failed') throw (jresponse['message']);
        final mosaiclist = jresponse['data']['category'];
        mosaiclist.forEach((element) {
          _mosaic.add(Products(
              int.parse(element['category_id']),
              element['category_name'].replaceAll('+', ' '),
              Uri.decodeFull(element['category_image'])));
        });
        print(_mosaic);
        return _mosaic;
      } else
        return _mosaic;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Product>> obtainproductitem(
      final int categoryId, final String session) async {
    try {
      print('hello\n\n\n');
      List<Product> productlist = [];
      final url =
          'http://dvj-design.com/api_dvj/Serv_v1/product_list?category_id=$categoryId&session=$session';
      final response = await http.get(url);
      final jresponse = json.decode(response.body);
      if (jresponse['status'] == 'failed') throw (jresponse['message']);
      final plist = jresponse['data']['products'];
      plist.forEach((element) {
        productlist.add(Product(
            int.parse(element['product_id']),
            element['product_name'].replaceAll('+', ' '),
            Uri.decodeFull(element['product_image']),
            Uri.decodeFull(element['bigproduct_image']),
            int.parse(element['category_id']),
            element['product_price'],
            element['datec'],
            int.parse(element['is_new_arrival']),
            int.parse(element['status'])));
      });
      print(productlist);
      return productlist;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> sendEnquiry(
      final String name, final String phone, final String session,
      {final String email = null, final String msg = null}) async {
    try {
      String url =
          'https://dvj-design.com/api_dvj/Serv_v1/enquiry?enquiry_name=$name&enquiry_mobile=$phone&session=$session';
      if (email != null) url += '&enquiry_emailid=$email';
      if (msg != null) url += '&enquiry_msg=$msg';
      if (_cartlist.length != 0) {
        List<Map> prod = [];
        _cartlist.forEach((element) {
          prod.add({
            "product_name": element.product.name,
            "product_qty": element.quantity
          });
        });
        url += prod.toString();
      }
      print(url);
      final response = await http.get(url);
      final jresponse = json.decode(response.body);
      print(jresponse);
      if (jresponse['status'] == 'failed') throw jresponse['message'];
      return true;
    } catch (e) {
      throw e.toString();
    }
  }
}
