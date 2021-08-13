import 'package:flutter_web_app/datamodels/routing_data.dart';

extension StringExtension on String {
  RoutingData get getRoutingData {
    var uriData = Uri.parse(this);
    print("queryParameters: ${uriData.queryParameters} path: ${uriData.path}");
    return RoutingData(
      queryParameters: uriData.queryParameters,
      route: uriData.path
    );
  }
}