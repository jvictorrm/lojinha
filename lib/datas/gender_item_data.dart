import 'package:lojinha/datas/color_data.dart';

class GenderItemData {
  double price;
  List<String> sizes;
  List<ColorData> colors;

  GenderItemData.fromMap(Map<String, dynamic> map) {
    this.price = map['price'];
    this.sizes = List<String>.from(map['sizes'].map((item) => item));
    this.colors = List<ColorData>.from(
        map['colors'].map((item) => ColorData.fromMap(item)));
  }
}
