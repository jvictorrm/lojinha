import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lojinha/models/user_model.dart';
import 'package:lojinha/screens/login_screen.dart';
import 'package:lojinha/widgets/custom_background.dart' as bgGrad;
import 'package:lojinha/widgets/tiles/drawer_tiles.dart';
import 'package:scoped_model/scoped_model.dart';

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
                      child: ScopedModelDescendant<UserModel>(
                          builder: (context, child, model) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Olá, ${!model.isLoggedIn() ? "" : model.user["name"].split(" ")[0]}",
                                style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              GestureDetector(
                                child: Row(
                                  children: [
                                    Text(
                                        !model.isLoggedIn()
                                            ? "Entre ou cadastre-se "
                                            : "Sair",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white,
                                            decoration:
                                                TextDecoration.underline)),
                                    Icon(
                                      !model.isLoggedIn()
                                          ? Icons.lock_outline
                                          : Icons.exit_to_app,
                                      color: Colors.white,
                                      size: 18.0,
                                    )
                                  ],
                                ),
                                onTap: () {
                                  if (!model.isLoggedIn()) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  } else {
                                    model.signOut();
                                  }
                                },
                              )
                            ]);
                      }),
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
