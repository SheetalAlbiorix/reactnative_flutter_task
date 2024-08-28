import 'dart:convert';

import 'package:reactnativetask/utils/base_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/store_list_model.dart';

class SharedData {
  ///Save and Read user isLogged in
  Future<void> saveUserCredentialsData(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(BaseStrings.isUserLoggedIn, value);
  }

  Future<bool> readUserCredentialsData(value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(BaseStrings.isUserLoggedIn) ?? false;
  }

  /// Save and read list data
  Future<void> saveDataStored(List<StoreListModel> list) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonList = list.map((item) => json.encode(item)).toList();
    await prefs.setStringList(BaseStrings.savedData, jsonList);
  }

  Future<List<StoreListModel>> readDataStored() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList(BaseStrings.savedData);
    if (jsonList == null) {
      return [];
    }
    return jsonList
        .map((item) => StoreListModel.fromJson(json.decode(item)))
        .toList();
  }

  ///Save and Read Token
  Future<void> saveToken(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(BaseStrings.token, json.encode(value));
  }

  Future<String?> readToken() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(BaseStrings.token);
    return data != null ? json.decode(data) : null;
  }

  ///Clear Shared Data
  Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
