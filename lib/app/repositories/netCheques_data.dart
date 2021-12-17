import 'package:flutter/cupertino.dart';
import 'package:netCheques/services/api.dart';
import 'package:netCheques/services/endpoint_data.dart';

class EndpointsData {
  EndpointsData({@required this.values});
  final Map<Endpoint, EndpointData> values;
  EndpointData get transactions => values[Endpoint.transaction];

  @override
  String toString() => 'transaction: $transactions';
}
