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
  List<CartProduct> _cartlist = [
    CartProduct(Product(3, 'Kona', 'assets/images/1.jpeg'), 1)
  ];
  List<Product> _productlist = [
    Product(3, 'Kona', 'assets/images/1.jpeg'),
    Product(4, 'joka', 'assets/images/3.jpeg'),
    Product(5, 'jdhvf', 'assets/images/4.jpeg'),
    Product(6, 'manio', 'assets/images/5.jpeg')
  ];
  List<Products> _productslist = [
    Products(1, 'Vulcano', 'assets/images/2.jpg', [
      Product(3, 'Kona', 'assets/images/1.jpeg'),
      Product(4, 'joka', 'assets/images/3.jpeg'),
    ]),
    Products(2, 'Adobe', 'assets/images/6.jpg', [
      Product(5, 'jdhvf', 'assets/images/4.jpeg'),
      Product(6, 'manio', 'assets/images/5.jpeg')
    ])
  ];

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
