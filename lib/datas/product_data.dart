import 'package:lojinha/datas/gender_data.dart';

class ProductData {
  int id;
  String title;
  String description;
  List<GenderData> genders;

  ProductData.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.description = map['description'];
    this.genders = List<GenderData>.from(
        map['genders'].map((item) => GenderData.fromMap(item)));
  }
}
