import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lojinha/models/user_model.dart';
import 'package:lojinha/screens/signup_screen.dart';
import 'package:lojinha/widgets/custom_button.dart';
import 'package:lojinha/widgets/custom_text_form.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // global keys
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Login"),
          centerTitle: true,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(15.0),
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 30.0),
                    child: SvgPicture.asset(
                      "images/logo.svg",
                      color: Colors.white,
                      semanticsLabel: 'Logo da Nike',
                      width: 50.0,
                      height: 50.0,
                    )),
                CustomTextForm(
                    label: "E-mail",
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress),
                SizedBox(
                  height: 15.0,
                ),
                CustomTextForm(
                  label: "Senha",
                  controller: _passwordController,
                  obscureText: true,
                ),
                SizedBox(
                  height: 15.0,
                ),
                CustomButton(
                  "Entrar",
                  () {
                    if (!_formKey.currentState.validate()) {}

                    model.signIn(
                        email: _emailController.text,
                        password: _passwordController.text,
                        onSuccess: _onSuccess,
                        onFail: _onFail);
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                FlatButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if (_emailController.text.isEmpty) {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text(
                            "Informe seu email para recuperação",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          backgroundColor: Theme.of(context).backgroundColor,
                          duration: Duration(seconds: 2)));
                      return;
                    }
                    model.recoverPass(_emailController.text);
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text(
                          "Foi enviado um email para recuperação de senha",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Theme.of(context).backgroundColor,
                        duration: Duration(seconds: 2)));
                  },
                  child: Text(
                    "Esqueceu a senha?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        decoration: TextDecoration.underline),
                  ),
                ),
                Divider(
                  height: 30.0,
                  color: Colors.grey,
                  thickness: 0.5,
                ),
                CustomButton(
                  "Criar nova conta",
                  () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => SignupScreen()));
                  },
                  backgroundColor: Colors.grey,
                  textColor: Theme.of(context).backgroundColor,
                )
              ],
            ),
          );
        }));
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "Falha no login",
          style: TextStyle(color: Colors.redAccent),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        duration: Duration(seconds: 2)));
  }
}
