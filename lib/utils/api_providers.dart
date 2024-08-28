import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:reactnativetask/utils/shared_data.dart';

import 'package:http/http.dart' as http;

import 'base_strings.dart';
import 'custom_exceptions.dart';

class ApiProvider {
  Uri? uri;
  SharedData sharedData = SharedData();
  String? stripeCustomerId = "";

  /// Get Without Token and URL
  Future<dynamic> getWithoutTokenUrl(String url) async {
    dynamic responseJson;
    try {
      uri = Uri.parse(url);

      final response = await http.get(uri!, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });
      responseJson = _response(response);
      log("Res : $responseJson");
    } on SocketException {
      throw NoInternetException(BaseStrings.noInternetConnection);
    }
    return responseJson;
  }

  /// Post Without Token
  Future<dynamic> postWithoutToken(String url, var body) async {
    dynamic responseJson;
    try {
      uri = Uri.parse(BaseStrings.baseUrl + url);
      final response = await http.post(uri!,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: body);

      responseJson = _response(response);
      log("Res : $responseJson");
    } on SocketException {
      throw BadRequestException('No Internet connection');
    }
    return responseJson;
  }

  /// Patch Request
  Future<dynamic> patch(String url, {var body}) async {
    dynamic responseJson;
    dynamic response;
    try {
      String? token = await sharedData.readToken();
      if (token != null) {
        uri = Uri.parse(BaseStrings.baseUrl + url);
        if (body == null) {
          response = await http.patch(uri!, headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "Authorization": "Bearer $token",
          });
        } else {
          response = await http.patch(uri!,
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                "Authorization": "Bearer $token",
              },
              body: body);
        }
        responseJson = _response(response);
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  /// Post With Token
  Future<dynamic> postWithToken(String url, var body) async {
    dynamic responseJson;
    try {
      String? token = await sharedData.readToken();
      if (token != null) {
        uri = Uri.parse(BaseStrings.baseUrl + url);
        final response = await http.post(uri!,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              "Authorization": "Bearer $token",
              'accept': '*/*'
            },
            body: body);
        responseJson = _response(response);
        log("Res : $responseJson");
        // debugPrint(responseJson);
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  /// Get Without Token
  Future<dynamic> getWithoutToken(String url, String parameter) async {
    dynamic responseJson;
    try {
      uri = Uri.parse(BaseStrings.baseUrl + url + parameter);

      final response = await http.get(uri!, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });
      responseJson = _response(response);
      log("Res : $responseJson");
    } on SocketException {
      throw NoInternetException(BaseStrings.noInternetConnection);
    }
    return responseJson;
  }

  /// Get With Token with parameter
  Future<dynamic> getWithTokenParameter(String url, String parameter) async {
    dynamic responseJson;
    try {
      uri = Uri.parse(BaseStrings.baseUrl + url + parameter);
      final response = await http.get(
        uri!,
      );
      responseJson = _response(response);
    } on SocketException {
      throw NoInternetException(BaseStrings.noInternetConnection);
    }
    return responseJson;
  }

  /// Get With Token
  Future<dynamic> getWithToken(String url) async {
    dynamic responseJson;
    String? token = await sharedData.readToken();
    if (token != null) {
      try {
        uri = Uri.parse(BaseStrings.baseUrl + url);
        final response = await http.get(
          uri!,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            "Authorization": "Bearer $token",
            'accept': '*/*'
          },
        );
        responseJson = _response(response);
      } on SocketException {
        throw NoInternetException(BaseStrings.noInternetConnection);
      }
    }
    return responseJson;
  }

  /// Delete With Token
  Future<dynamic> deleteWithToken(String url, var body) async {
    dynamic responseJson;
    try {
      String? token = await sharedData.readToken();
      if (token != null) {
        uri = Uri.parse(BaseStrings.baseUrl + url);
        final response = await http.delete(uri!,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              "Authorization": "Bearer $token",
              'accept': '*/*'
            },
            body: body);
        responseJson = _response(response);
        log("Res : $responseJson");
        // debugPrint(responseJson);
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }





  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 204:
        return "Success";
      case 412:
      case 400:
        var responseJson = json.decode(response.body.toString());
        var msg = responseJson["message"];
        throw BadRequestException(msg);
      case 401:
        var responseJson = json.decode(response.body.toString());
        var msg = responseJson["message"];
        if (msg == "Invalid Credential") {
          throw BadRequestException(msg);
        } else if (msg == "Unauthorized") {
          throw BadRequestException(msg);
        } else {
          // check(msg);
        }
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        var responseJson = json.decode(response.body.toString());
        var msg = responseJson["message"];
        throw BadRequestException(msg);
      case 409:
        var responseJson = json.decode(response.body.toString());
        var msg = responseJson["message"];
        throw NoInternetException(msg);
      case 500 || 502:
        var responseJson = json.decode(response.body.toString());
        var error = responseJson["message"] ?? "";

        throw NoInternetException(error);
      default:
        var responseJson = json.decode(response.body.toString());
        var msg = responseJson["message"];
        throw NoInternetException(msg);
    }
  }
}
