import 'package:flutter/foundation.dart';

class EndpointData {
  EndpointData({@required this.phoneNumber}) : assert(phoneNumber != null);
  final String phoneNumber;

  @override
  String toString() => 'phoneNumber: $phoneNumber';
}
