import 'dart:convert';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:lojinha/widgets/custom_background.dart' as bgGrad;

class HomeTab extends StatelessWidget {
  Future<List<dynamic>> _getDataPromos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response responseAPI =
        await http.get("${prefs.get("apiURL")}/promos?_sort=pos");

    if (responseAPI.statusCode == 200 &&
        !responseAPI.reasonPhrase.contains('Not found')) {
      return json.decode(responseAPI.body);
    }
    return List<dynamic>();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildImagesGrid(BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
        case ConnectionState.waiting:
          return SliverToBoxAdapter(
            child: Center(
                heightFactor: 15.0,
                child: Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )),
          );
        default:
          if (snapshot.hasError || snapshot.data.isEmpty) {
            return SliverToBoxAdapter(
                child: Center(
                    heightFactor: 3.0,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                                  "Não foi possível atualizar nosso feed. Tente novamente.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20.0,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ))
                          ],
                        ))));
          }
      }

      return SliverStaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          staggeredTiles: List<StaggeredTile>.from(snapshot.data.map(
              (element) => StaggeredTile.count(element['x'], element['y']))),
          children: List<FadeInImage>.from(
              snapshot.data.map((element) => FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: element['image_url'],
                    fit: BoxFit.cover,
                  ))));
    }

    return Stack(
      children: [
        bgGrad.buildGradientBackground([Colors.black, Colors.white],
            Alignment.topLeft, Alignment.bottomRight),
        CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: const Text(
                        "lojinha",
                        style: TextStyle(fontFamily: 'Oxanium'),
                      )),
                  SvgPicture.asset(
                    "images/logo.svg",
                    color: Colors.white,
                    semanticsLabel: 'Logo da Nike',
                    width: 20.0,
                    height: 20.0,
                  )
                ]),
              ),
            ),
            FutureBuilder<List<dynamic>>(
              future: _getDataPromos(),
              builder: _buildImagesGrid,
            ),
          ],
        )
      ],
    );
  }
}
