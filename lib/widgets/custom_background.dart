import 'package:flutter/material.dart';

Widget buildGradientBackground(
        List<Color> colors, Alignment begin, Alignment end) =>
    Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: colors,
        begin: begin,
        end: end,
      )),
    );
