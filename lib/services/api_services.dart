import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:netCheques/services/api.dart';

class APIService {
  APIService({@required this.api});
  final API api;

  Future<int> doAuth(
      {@required String password, @required String phoneNumber}) async {
    print(phoneNumber);
    print(password);

    final String type = await FlutterSession().get("type");
    final response = await http.post(api.authURI().toString(),
        body: jsonEncode(<String, dynamic>{
          "pass": password.toString(),
          "phone": phoneNumber.toString(),
          "coll": type.toString(),
          "name": phoneNumber.toString()
        }));

    if (response.statusCode == 200) {
      // final data = json.decode(response.body);
      return response.statusCode;
    }
    print(
        'Request ${api.authURI()} failed\nResponse: ${response.statusCode} ${response.headers}');
    throw response;
  }

  Future<Map> doSend(
      {@required String phoneNumber,
      @required String toWhom,
      @required double amount}) async {
    var session = FlutterSession();
    final userPhoneNumber = await session.get("phoneNumber");
    final type = await session.get("type");
    print(type.toString());
    print(userPhoneNumber);
    print(toWhom);
    print(phoneNumber);
    print(amount);
    final response =
        await http.post(api.getURI(endpoint: Endpoint.transaction).toString(),
            body: jsonEncode(<String, dynamic>{
              "fromColl": type.toString(),
              "fromPhone": userPhoneNumber.toString(),
              "toColl": toWhom.toString(),
              "toPhone": phoneNumber.toString(),
              "amt": amount
            }));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    }
    print(
        'Request ${api.getURI(endpoint: Endpoint.transaction)} failed\nResponse: ${response.statusCode} ${response.headers}');
    throw response;
  }

  Future<Map> doSubmitRequestForHardWallet(
      {@required String walletName, @required double discount}) async {
    var session = FlutterSession();
    final userPhoneNumber = await session.get("phoneNumber");
    // final type = await session.get("type");
    final discountWeight = discount / 100.0;
    final response =
        await http.post(api.getURI(endpoint: Endpoint.hardWallet).toString(),
            body: jsonEncode(<String, dynamic>{
              "phone": userPhoneNumber.toString(),
              "hardPercent": discountWeight,
              "coll": "merchants"
            }));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    }
    print(
        'Request ${api.getURI(endpoint: Endpoint.hardWallet)} failed\nResponse: ${response.statusCode} ${response.headers}');
    throw response;
  }
  // Future<int> getEndpointData(
  //     {@required Endpoint endpoint, @required String accessToken}) async {
  //   final uri = api.getURI(endpoint: endpoint);
  //   final response = await http
  //       .get(uri.toString(), headers: {'Authorization': 'Bearer $accessToken'});
  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = json.decode(response.body);
  //     if (data.isNotEmpty) {
  //       final Map<String, dynamic> endPointData = data[0];
  //       final String responseJsonKey = _responseJsonKeys[endpoint];
  //       final int result = endPointData[responseJsonKey];
  //       if (result != null) return result;
  //     }
  //   }
  //   print(
  //       'Request ${api.tokenURI()} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');

  //   throw response;
  // }

  // ignore: unused_field
  Map<Endpoint, String> _responseJsonKeys = {
    Endpoint.transaction: 'transaction'
  };
}
