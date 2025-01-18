import 'package:flutter/foundation.dart';
import 'package:fundamakers/helper/network/base_api_services.dart';
import 'package:fundamakers/helper/network/network_api.dart';
import 'package:fundamakers/models/concepts_model.dart';
import 'package:fundamakers/res/app_url.dart';

class NotesEbooksRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<ConceptsModel> notesEbookApi(
      dynamic data) async {
    try {
      dynamic response = await _apiServices.getGetApiBearerResponse(
          '${AppUrls.conceptsReads}withSubject=$data');
      return ConceptsModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during notesEbookApi: $e');
      }
      rethrow;
    }
  }
}
