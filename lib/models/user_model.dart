import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserModel extends Model {
  Map<String, dynamic> user = Map();

  void signUp(
      {@required Map<String, dynamic> userData,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    user = null;
    notifyListeners();
    user = await _storeUser(userData);
    notifyListeners();
  }

  void signIn() async {
    user = null;
    notifyListeners();
    user = await _authAPI(1);
    notifyListeners();
  }

  void recoverPass() {}

  bool isLoggedIn() {
    return true;
  }

  Future<Map<String, dynamic>> _authAPI(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response responseAPI =
        await http.get("${prefs.get("apiURL")}/users/$id");

    if (responseAPI.statusCode == 200 &&
        !responseAPI.reasonPhrase.contains('Not found')) {
      return json.decode(responseAPI.body);
    }
    return Map<String, dynamic>();
  }

  Future<Map<String, dynamic>> _storeUser(Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response responseAPI = await http.post("${prefs.get("apiURL")}/users",
        body: json.encode(userData),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (responseAPI.statusCode == 200 &&
        !responseAPI.reasonPhrase.contains('Not found')) {
      return json.decode(responseAPI.body);
    }
    return Map<String, dynamic>();
  }
}
