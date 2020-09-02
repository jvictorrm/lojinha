import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserModel extends Model {
  Map<String, dynamic> user = Map();
  bool isLoading = false;

  void signUp(
      {@required Map<String, dynamic> userData,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    user = null;
    isLoading = true;
    notifyListeners();
    user = await _storeUser(userData);

    if (user == null) {
      onFail();
    } else {
      onSuccess();
    }

    isLoading = false;
    notifyListeners();
  }

  void signIn(
      {@required String email,
      @required String password,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    user = null;
    isLoading = true;
    notifyListeners();
    user = await _authAPI(email, password);

    if (user == null) {
      onFail();
    } else {
      onSuccess();
    }

    isLoading = false;
    notifyListeners();
  }

  void recoverPass(String newPassword) {}

  bool isLoggedIn() {
    return user != null && user.isNotEmpty;
  }

  void signOut() {
    user = null;
    notifyListeners();
  }

  Future<Map<String, dynamic>> _authAPI(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response responseAPI =
        await http.get("${prefs.get("apiURL")}/users/1");

    if (responseAPI.statusCode.toString().startsWith("20") &&
        !responseAPI.reasonPhrase.contains('Not found')) {
      return json.decode(responseAPI.body);
    }
    return null;
  }

  Future<Map<String, dynamic>> _storeUser(Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response responseAPI = await http.post("${prefs.get("apiURL")}/users",
        body: json.encode(userData),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (responseAPI.statusCode.toString().startsWith("20") &&
        !responseAPI.reasonPhrase.contains('Not found')) {
      return json.decode(responseAPI.body);
    }
    return null;
  }
}
