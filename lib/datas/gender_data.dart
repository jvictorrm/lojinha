import 'package:lojinha/datas/gender_item_data.dart';

class GenderData {
  String gender;
  List<GenderItemData> items;

  GenderData.fromMap(Map<String, dynamic> map) {
    this.gender = map['gender'];
    this.items = List<GenderItemData>.from(
        map['items'].map((item) => GenderItemData.fromMap(item)));
  }
}
