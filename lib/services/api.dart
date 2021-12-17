import 'package:flutter/material.dart';
// import 'package:netCheques/services/api_keys.dart';

enum Endpoint { transaction, hardWallet }

class API {
  API();
  factory API.sandbox() => API();

  static String host = 'gjryzxeja1.execute-api.ap-south-1.amazonaws.com';
  Uri authURI() => Uri(scheme: 'https', host: host, path: 'fakeSetup1/auth');
  // factory API.initiate() => API(apiKey: APIKeys.netChequesAPIKey);

  Uri getURI({@required Endpoint endpoint}) =>
      Uri(scheme: 'https', host: host, path: _paths[endpoint]);

  Map<Endpoint, String> _paths = {
    Endpoint.transaction: 'fakeSetup1/transactions',
    Endpoint.hardWallet: 'fakeSetup1/hardopt'
  };
}
