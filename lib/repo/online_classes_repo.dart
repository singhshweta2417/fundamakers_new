import 'package:flutter/foundation.dart';
import 'package:fundamakers/helper/network/base_api_services.dart';
import 'package:fundamakers/helper/network/network_api.dart';
import 'package:fundamakers/models/online_classes_model.dart';
import 'package:fundamakers/res/app_url.dart';

class OnlineClassesRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  ///ONLINE-CLASSES
  Future<OnlineClassesModel> onlineClassesApi() async {
    try {
      dynamic response =
          await _apiServices.getGetApiBearerResponse(AppUrls.onlineClassesUrls);
      return OnlineClassesModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during onlineClassesApi: $e');
      }
      rethrow;
    }
  }
}
