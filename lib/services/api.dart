import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>> post(
      {@required String url, @required Map<String, dynamic> data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.Response responseAPI = await http.get("${prefs.get("apiURL")}$url");

    if (responseAPI.statusCode.toString().startsWith("20") &&
        !responseAPI.reasonPhrase.contains('Not found')) {
      return json.decode(responseAPI.body);
    }
    return null;
  }
}
