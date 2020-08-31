import 'package:flutter/material.dart';
import 'package:lojinha/screens/tabs/home_tab.dart';
import 'package:lojinha/screens/tabs/products_categories_tab.dart';
import 'package:lojinha/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          body: ProductsCategoriesTab(),
          drawer: CustomDrawer(_pageController),
        )
      ],
    );
  }
}
