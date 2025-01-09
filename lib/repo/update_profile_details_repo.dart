import 'package:flutter/foundation.dart';
import 'package:fundamakers/helper/network/base_api_services.dart';
import 'package:fundamakers/helper/network/network_api.dart';
import 'package:fundamakers/res/app_url.dart';

class UserDetailRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> userDetailsApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiBearerResponse(AppUrls.userDetailsUrls, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during userDetailsApi: $e');
      }
      rethrow;
    }
  }
  Future<dynamic> getUserDetailsApi() async {
    try {
      dynamic response =
      await _apiServices.getGetApiBearerResponse(AppUrls.userDetailsUrls);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during getUserDetailsApi: $e');
      }
      rethrow;
    }
  }
}
