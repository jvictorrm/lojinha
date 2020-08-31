import 'package:carousel_pro/carousel_pro.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:lojinha/datas/product_data.dart';
import 'package:lojinha/widgets/custom_button.dart';

class ProductScreen extends StatefulWidget {
  final ProductData productData;

  ProductScreen(this.productData);

  @override
  _ProductScreenState createState() => _ProductScreenState(this.productData);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData productData;
  String size;

  _ProductScreenState(this.productData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.productData.title),
          centerTitle: true,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: ListView(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Carousel(
                    indicatorBgPadding: 15.0,
                    dotSpacing: 15.0,
                    dotSize: 5.0,
                    dotIncreaseSize: 2.0,
                    dotIncreasedColor: Theme.of(context).backgroundColor,
                    dotColor: Theme.of(context).primaryColor,
                    dotBgColor: Colors.transparent,
                    autoplay: false,
                    images: List<Image>.from(this
                        .productData
                        .genders[0]
                        .items[0]
                        .colors[0]
                        .images
                        .map((i) => Image.network(i.imageUrl))),
                  )),
            ),
            Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(this.productData.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                    Text(
                        "R\$ ${this.productData.genders[0].items[0].price.toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text("Tamanho",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 30.0,
                      child: GridView(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 0.5),
                        children: List<GestureDetector>.from(this
                            .productData
                            .genders[0]
                            .items[0]
                            .sizes
                            .map((s) => GestureDetector(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 50.0,
                                    decoration: BoxDecoration(
                                        color: size == s
                                            ? Colors.grey
                                            : Theme.of(context).backgroundColor,
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0))),
                                    child: Text(
                                      s,
                                      style: TextStyle(
                                          color: size == s
                                              ? Theme.of(context)
                                                  .backgroundColor
                                              : Colors.white),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      size = s;
                                    });
                                  },
                                ))),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    CustomButton(
                      "Adicionar ao carrinho",
                      () {},
                      isActivated: size != null,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text("Descrição",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold)),
                    ExpandableNotifier(
                        child: Column(children: [
                      Expandable(
                          expanded: ExpandableButton(
                            child: Text(this.productData.description,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0)),
                          ),
                          collapsed: Column(
                            children: [
                              Text(this.productData.description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0)),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: ExpandableButton(
                                      child: Text(
                                    "Ver mais",
                                    style: TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration.underline),
                                  )))
                            ],
                          ))
                    ])),
                  ],
                ))
          ],
        ));
  }
}
