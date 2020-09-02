import 'package:flutter/material.dart';
import 'package:lojinha/models/user_model.dart';
import 'package:lojinha/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(Main());
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then(
        (prefs) => prefs.setString("apiURL", "http://b48da9236e35.ngrok.io"));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
        child: MaterialApp(
            title: 'lojinha',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                inputDecorationTheme: InputDecorationTheme(
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.white,
                  )),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.white10,
                  )),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.white38,
                  )),
                ),
                backgroundColor: Color.fromARGB(255, 21, 21, 21),
                primaryColor: Color.fromARGB(255, 42, 42, 42),
                fontFamily: 'Oxanium'),
            home: HomeScreen()));
  }
}
