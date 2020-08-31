import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lojinha/screens/login_screen.dart';
import 'package:lojinha/widgets/custom_background.dart' as bgGrad;
import 'package:lojinha/widgets/tiles/drawer_tiles.dart';

class CustomDrawer extends StatelessWidget {
  final PageController _pageController;

  CustomDrawer(this._pageController);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          bgGrad.buildGradientBackground(
              [Theme.of(context).primaryColor, Theme.of(context).primaryColor],
              Alignment.topCenter,
              Alignment.bottomCenter),
          ListView(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: [
                    Positioned(
                        top: 8.0,
                        left: 80.0,
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              "images/logo.svg",
                              color: Colors.white,
                              semanticsLabel: 'Logo da Nike',
                              width: 50.0,
                              height: 50.0,
                            )
                          ],
                        )),
                    Positioned(
                      left: 10.0,
                      bottom: 0.0,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Olá, ",
                                style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white,
                                )),
                            GestureDetector(
                              child: Row(
                                children: [
                                  Text("Entre ou cadastre-se ",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                          decoration:
                                              TextDecoration.underline)),
                                  Icon(
                                    Icons.launch,
                                    color: Colors.white,
                                    size: 18.0,
                                  )
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                              },
                            )
                          ]),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.white,
                thickness: 1.0,
              ),
              DrawerTile(Icons.home, "Início", this._pageController, 0),
              DrawerTile(Icons.list, "Produtos", this._pageController, 1),
              DrawerTile(Icons.location_on, "Lojas", this._pageController, 2),
              DrawerTile(Icons.playlist_add_check, "Meus Pedidos",
                  this._pageController, 3)
            ],
          )
        ],
      ),
    );
  }
}
