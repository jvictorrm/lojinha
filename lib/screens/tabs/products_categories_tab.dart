import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lojinha/widgets/tiles/category_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsCategoriesTab extends StatelessWidget {
  Future<List<dynamic>> _getDataProductsCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response responseAPI =
        await http.get("${prefs.get("apiURL")}/productsCategories?_sort=title");

    if (responseAPI.statusCode == 200 &&
        !responseAPI.reasonPhrase.contains('Not found')) {
      return json.decode(responseAPI.body);
    }
    return List<dynamic>();
  }

  Widget _buildList(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return Container(
          color: Theme.of(context).primaryColor,
          //height: 200.0,
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        );
      default:
        if (snapshot.hasError || snapshot.data.isEmpty) {
          return Container(
              padding: EdgeInsets.only(top: 100.0, left: 50.0, right: 50.0),
              color: Theme.of(context).primaryColor,
              child: Column(
                children: [
                  const Icon(
                    Icons.cloud_off,
                    size: 50.0,
                    color: Colors.white,
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: const Text(
                        "Não foi possível atualizar nossa lista de Categorias de produtos. Tente novamente.",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20.0,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ))
                ],
              ));
        }
    }

    var dividedTiles = ListTile.divideTiles(
            tiles: List<CategoryTile>.from(
                snapshot.data.map((item) => CategoryTile(item))),
            color: Colors.grey)
        .toList();

    return Stack(
      children: [
        Container(
          color: Theme.of(context).backgroundColor,
        ),
        ListView(children: dividedTiles)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getDataProductsCategories(), builder: _buildList);
  }
}
