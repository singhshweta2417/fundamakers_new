import 'package:flutter/foundation.dart';
import 'package:fundamakers/helper/network/base_api_services.dart';
import 'package:fundamakers/helper/network/network_api.dart';
import 'package:fundamakers/models/plans/plan_list_model.dart';
import 'package:fundamakers/res/app_url.dart';

class PlansRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<PlansListModel> planApi(dynamic data) async {
    try {
      dynamic response = await _apiServices
          .getGetApiBearerResponse('${AppUrls.plansUrls}sub_course_id=$data');
      return PlansListModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during planApi: $e');
      }
      rethrow;
    }
  }
}
