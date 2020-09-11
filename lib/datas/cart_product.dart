import 'package:lojinha/datas/product_data.dart';

class CartProduct {
  int id;
  int categoryId;
  int productId;
  int quantity;
  String size;

  ProductData productData;

  CartProduct.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    categoryId = map['categoryId'];
    productId = map['productId'];
    quantity = map['id'];
    size = map['size'];
    productData = ProductData.fromMap(map['productData']);
  }
}
