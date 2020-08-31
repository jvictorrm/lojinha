import 'package:flutter/material.dart';
import 'package:lojinha/screens/category_screen.dart';

class CategoryTile extends StatelessWidget {
  final Map<String, dynamic> productCategoryMap;

  CategoryTile(this.productCategoryMap);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        child: ListTile(
          title: Text(
            this.productCategoryMap['title'],
            style: TextStyle(color: Colors.white),
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CategoryScreen(productCategoryMap)));
          },
        ));
  }
}
