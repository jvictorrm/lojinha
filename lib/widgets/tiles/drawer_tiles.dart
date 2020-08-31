import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController pageController;
  final int page;

  DrawerTile(this.icon, this.text, this.pageController, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
            this.pageController.jumpToPage(this.page);
          },
          child: Container(
            height: 60.0,
            color: this.pageController.page.round() == this.page
                ? Colors.black
                : Colors.transparent,
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  Icon(
                    this.icon,
                    size: 32.0,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 32.0,
                  ),
                  Text(this.text,
                      style: TextStyle(fontSize: 16.0, color: Colors.white)),
                ],
              ),
            ),
          )),
    );
  }
}
