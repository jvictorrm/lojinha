import 'package:flutter/material.dart';
import 'package:lojinha/datas/product_data.dart';
import 'package:lojinha/enums/product_tile_enum.dart';
import 'package:lojinha/widgets/tiles/product_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryScreen extends StatelessWidget {
  final Map<String, dynamic> productCategoryMap;

  CategoryScreen(this.productCategoryMap);

  Future<Map<String, dynamic>> _getProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response responseAPI = await http.get(
        "${prefs.get("apiURL")}/productsCategories/${this.productCategoryMap["id"]}");

    if (responseAPI.statusCode == 200 &&
        !responseAPI.reasonPhrase.contains('Not found')) {
      return json.decode(responseAPI.body);
    }
    return Map<String, dynamic>();
  }

  Widget _buildCategoryItems(BuildContext context, AsyncSnapshot snapshot) {
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
        if (snapshot.hasError || snapshot.data['products'].isEmpty) {
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
                        "Não foi possível atualizar nossos produtos. Tente novamente.",
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

    return TabBarView(physics: NeverScrollableScrollPhysics(), children: [
      GridView.builder(
          padding: EdgeInsets.all(3.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 4.0, crossAxisSpacing: 4.0),
          itemCount: snapshot.data['products'].length,
          itemBuilder: (context, index) {
            return ProductTile(ProductTileEnum.GRID,
                ProductData.fromMap(snapshot.data['products'][index]));
          }),
      ListView.builder(
          padding: EdgeInsets.all(3.0),
          itemCount: snapshot.data['products'].length,
          itemBuilder: (context, index) {
            return ProductTile(ProductTileEnum.LIST,
                ProductData.fromMap(snapshot.data['products'][index]));
          })
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text(this.productCategoryMap['title']),
              centerTitle: true,
              bottom: TabBar(indicatorColor: Colors.grey, tabs: [
                Tab(icon: Icon(Icons.grid_on)),
                Tab(icon: Icon(Icons.list))
              ]),
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            body: FutureBuilder(
                future: _getProducts(), builder: _buildCategoryItems)));
  }
}
