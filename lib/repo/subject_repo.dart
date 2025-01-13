import 'package:flutter/foundation.dart';
import 'package:fundamakers/helper/network/base_api_services.dart';
import 'package:fundamakers/helper/network/network_api.dart';
import 'package:fundamakers/models/subjects/subject_model.dart';
import 'package:fundamakers/res/app_url.dart';

class SubjectRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<SubjectModel> subjectApi() async {
    try {
      dynamic response = await _apiServices
          .getGetApiBearerResponse(AppUrls.subjectsUrls);
      return SubjectModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during subjectApi: $e');
      }
      rethrow;
    }
  }
}
