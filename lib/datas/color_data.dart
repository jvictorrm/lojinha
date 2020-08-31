import 'package:lojinha/datas/image_data.dart';

class ColorData {
  String color;
  List<ImageData> images;

  ColorData.fromMap(Map<String, dynamic> map) {
    this.color = map['color'];
    this.images = List<ImageData>.from(
        map['images'].map((item) => ImageData.fromMap(item)));
  }
}
