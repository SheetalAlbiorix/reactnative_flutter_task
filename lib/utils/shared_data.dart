import 'dart:convert';

import 'package:reactnativetask/utils/base_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/store_list_model.dart';

class SharedData {
  ///Save and Read user Credentials
  Future<void> saveUserCredentialsData(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(BaseStrings.isUserLoggedIn, value);
  }

  Future<bool> readUserCredentialsData(value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(BaseStrings.isUserLoggedIn) ?? false;
  }

  Future<void> saveDataStored(List<StoreListModel> list) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonList = list.map((item) => json.encode(item)).toList();
    await prefs.setStringList(BaseStrings.savedData, jsonList);
  }

  Future<List<StoreListModel>> getDataStored() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList(BaseStrings.savedData);
    if (jsonList == null) {
      return [];
    }
    return jsonList
        .map((item) => StoreListModel.fromJson(json.decode(item)))
        .toList();
  }
}
