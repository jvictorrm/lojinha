import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lojinha/models/user_model.dart';
import 'package:lojinha/widgets/custom_button.dart';
import 'package:lojinha/widgets/custom_text_form.dart';
import 'package:scoped_model/scoped_model.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();

  // global keys
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Cadastrar conta"),
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
                  label: "Nome",
                  controller: _nameController,
                ),
                SizedBox(
                  height: 15.0,
                ),
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
                CustomTextForm(
                  label: "Endereço",
                  controller: _addressController,
                ),
                SizedBox(
                  height: 30.0,
                ),
                CustomButton(
                  "Cadastrar",
                  () {
                    if (!_formKey.currentState.validate()) {}

                    Map<String, dynamic> userData = {
                      "id": 2,
                      "name": _nameController.text,
                      "email": _emailController.text,
                      "password": _passwordController.text,
                      "address": _addressController.text
                    };

                    model.signUp(
                        userData: userData,
                        onSuccess: _onSuccess,
                        onFail: _onFail);

                    model.signIn(
                        email: _emailController.text,
                        password: _passwordController.text,
                        onSuccess: _onSuccess,
                        onFail: _onFail);
                  },
                ),
              ],
            ),
          );
        }));
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        "Sua conta foi criada com sucesso!",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2))
        .then((_) => Navigator.of(context).pop());
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "Falha na criação da sua conta",
          style: TextStyle(color: Colors.redAccent),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        duration: Duration(seconds: 2)));
  }
}
