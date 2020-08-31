import 'package:lojinha/datas/product_data.dart';

class CategoryData {
  int id;
  String categoryTitle;
  List<ProductData> products;

  CategoryData.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.categoryTitle = map['title'];
    this.products = List<ProductData>.from(
        map['products'].map((item) => ProductData.fromMap(item)));
  }
}
