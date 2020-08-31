import 'package:flutter/material.dart';
import 'package:lojinha/datas/product_data.dart';
import 'package:lojinha/enums/product_tile_enum.dart';
import 'package:lojinha/screens/product_screen.dart';
import 'package:lojinha/widgets/custom_text_box.dart';

class ProductTile extends StatelessWidget {
  final ProductTileEnum productTileEnum;
  final ProductData productData;

  ProductTile(this.productTileEnum, this.productData);

  Widget _buildCard() {
    String title = productData.title;
    String gender = this.productData.genders[0].gender;
    double price = this.productData.genders[0].items[0].price;
    List<String> sizes = this.productData.genders[0].items[0].sizes;
    String imageUrl =
        this.productData.genders[0].items[0].colors[0].images[0].imageUrl;

    switch (this.productTileEnum) {
      case ProductTileEnum.GRID:
        return ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AspectRatio(
                    aspectRatio: 1.3,
                    child: Stack(fit: StackFit.expand, children: [
                      Container(
                        color: Colors.white,
                      ),
                      Image.network(imageUrl, fit: BoxFit.cover)
                    ])),
                Container(
                    height: 35.0,
                    margin: EdgeInsets.fromLTRB(2.0, 1.0, 2.0, 1.0),
                    //padding: EdgeInsets.fromLTRB(2.0, 1.0, 2.0, 1.0),
                    child: Stack(
                      children: [
                        Text(
                          title,
                          style: TextStyle(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "R\$ ${price.toStringAsFixed(2)}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Gênero: $gender",
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    ))
              ],
            ));
      case ProductTileEnum.LIST:
        return ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
                height: 150.0,
                child: Row(children: [
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.all(2.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: AspectRatio(
                                  aspectRatio: 1.0,
                                  child: Stack(fit: StackFit.expand, children: [
                                    Container(
                                      color: Colors.white,
                                    ),
                                    Image.network(imageUrl, fit: BoxFit.cover)
                                  ]))))),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    title,
                                    softWrap: true,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "Gênero: $gender",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white),
                                      )),
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Tam:",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white),
                                          ),
                                          Row(
                                              children: List<Widget>.from(
                                            sizes.take(5).map((sizeItem) =>
                                                sizes.length > 5 &&
                                                        sizes.take(5).last ==
                                                            sizeItem
                                                    ? CustomTextBox(Icon(
                                                        Icons.more_horiz,
                                                        color: Colors.white,
                                                        size: 15.0,
                                                      ))
                                                    : CustomTextBox(Text(
                                                        sizeItem,
                                                        style: TextStyle(
                                                            fontSize: 15.0,
                                                            color: Colors
                                                                .white)))),
                                          ))
                                        ],
                                      )),
                                ],
                              ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    "R\$ ${price.toStringAsFixed(2)}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ))),
                ])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        color: Theme.of(context).primaryColor,
        child: _buildCard(),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductScreen(this.productData)));
      },
    );
  }
}
