import 'package:flutter/foundation.dart';
import 'package:fundamakers/helper/network/base_api_services.dart';
import 'package:fundamakers/helper/network/network_api.dart';
import 'package:fundamakers/models/library/b_school_info_model.dart';
import 'package:fundamakers/models/library/class_hangouts_model.dart';
import 'package:fundamakers/models/library/previous_years_papers_model.dart';
import 'package:fundamakers/models/premium_features_model/gk_zone_model.dart';
import 'package:fundamakers/models/premium_features_model/practice_books_model.dart';
import 'package:fundamakers/res/app_url.dart';

class PremiumRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  ///PRACTICE-BOOK
  Future<PracticeBooksModel>practiceBookApi() async {
    try {
      dynamic response =
      await _apiServices.getGetApiBearerResponse(AppUrls.practiceBooksUrls);
      return PracticeBooksModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during practiceBookApi: $e');
      }
      rethrow;
    }
  }
  ///General-Knowledge
  Future<GkModel> gkApi() async {
    try {
      dynamic response =
          await _apiServices.getGetApiBearerResponse(AppUrls.gkUrls);
      return GkModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during gkApi: $e');
      }
      rethrow;
    }
  }

  ///LIBRARY
  ///CLASS-HANGOUTS
  Future<ClassHangOutsModel> classHandOutApi() async {
    try {
      dynamic response =
          await _apiServices.getGetApiBearerResponse(AppUrls.classHandoutsUrls);
      return ClassHangOutsModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during classHangOutApi: $e');
      }
      rethrow;
    }
  }
  ///B-SCHOOL-INFO
  Future<BSchoolInfoModel> bSchoolInfoApi() async {
    try {
      dynamic response =
      await _apiServices.getGetApiBearerResponse(AppUrls.bSchoolInfoUrls);
      return BSchoolInfoModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during bSchoolInfoApi: $e');
      }
      rethrow;
    }
  }

  ///PREVIOUS-YEAR-PAPER
  Future<PreviousYearModel> previousYearPaperApi() async {
    try {
      dynamic response =
      await _apiServices.getGetApiBearerResponse(AppUrls.previousYearPaperUrls);
      return PreviousYearModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during previousYearPaperApi: $e');
      }
      rethrow;
    }
  }
}
