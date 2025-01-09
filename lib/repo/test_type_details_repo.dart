import 'package:flutter/foundation.dart';
import 'package:fundamakers/helper/network/base_api_services.dart';
import 'package:fundamakers/helper/network/network_api.dart';
import 'package:fundamakers/res/app_url.dart';

class TestTypeDetailsRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> testTypeDetailApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getGetApiBearerResponse('${AppUrls.testTypeUrls}/$data');
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during testTypeDetailApi: $e');
      }
      rethrow;
    }
  }
}
