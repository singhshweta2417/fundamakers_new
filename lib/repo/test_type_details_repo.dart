import 'package:flutter/foundation.dart';
import 'package:fundamakers/helper/network/base_api_services.dart';
import 'package:fundamakers/helper/network/network_api.dart';
import 'package:fundamakers/models/test/test_list_model.dart';
import 'package:fundamakers/models/test_type_details_model.dart';
import 'package:fundamakers/res/app_url.dart';

class TestTypeDetailsRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  ///TEST-LISTS
  Future<TestListModel> testListApi() async {
    try {
      dynamic response =
          await _apiServices.getGetApiBearerResponse(AppUrls.testTypeUrls);
      return TestListModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during testListApi: $e');
      }
      rethrow;
    }
  }

  ///TEST TYPE DETAILS
  Future<TestTypeDetailsModel> testTypeDetailApi(dynamic data) async {
    try {
      dynamic response = await _apiServices
          .getGetApiBearerResponse('${AppUrls.testTypeUrls}/$data');
      return TestTypeDetailsModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during testTypeDetailApi: $e');
      }
      rethrow;
    }
  }
}
