import 'package:flutter/foundation.dart';

class Product {
  final id;
  final String name;
  final String imageUrl;
  Product(this.id, this.name, this.imageUrl);
}

class Products {
  final id;
  final String name;
  final String imageUri;
  final List<Product> list;
  Products(this.id, this.name, this.imageUri, this.list);
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
  List<Products> _productslist = [];
  List<CartProduct> _cartlist = [];
  List<Product> _productlist = [];

  get productlist => _productlist;
  get productslist => _productslist;
  get cartlist => _cartlist;

  void addtocart(var id) {
    Product tobeadded = _productlist.firstWhere((element) => element.id == id);
    _cartlist.add(CartProduct(tobeadded, 1));
    notifyListeners();
  }

  void removefromcart(var id) {
    _cartlist.removeWhere((element) => element.product.id == id);
    notifyListeners();
  }

  void changequantity(var id, var val) {
    var index = _cartlist.indexWhere((element) => element.product.id == id);
    _cartlist[index].changequantity(val);
  }
}
