import 'package:flutter/foundation.dart';
import 'package:fundamakers/helper/response/api_response.dart';
import 'package:fundamakers/models/library/b_school_info_model.dart';
import 'package:fundamakers/models/library/class_hangouts_model.dart';
import 'package:fundamakers/models/library/previous_years_papers_model.dart';
import 'package:fundamakers/models/premium_features_model/gk_zone_model.dart';
import 'package:fundamakers/models/premium_features_model/practice_books_model.dart';
import 'package:fundamakers/repo/premium_repo.dart';

class PremiumViewModel with ChangeNotifier {
  final _premiumRepo = PremiumRepository();

  ///PRACTICE-BOOK
  ApiResponse<PracticeBooksModel> _practiceBookResponse = ApiResponse.loading();

  ApiResponse<PracticeBooksModel> get practiceBookResponse =>
      _practiceBookResponse;

  void setPracticeBookModel(ApiResponse<PracticeBooksModel> response) {
    if (_practiceBookResponse != response) {
      _practiceBookResponse = response;
      notifyListeners();
    }
  }

  Future<void> practiceBookApi(context) async {
    setPracticeBookModel(ApiResponse.loading());
    try {
      final value = await _premiumRepo.practiceBookApi();
      setPracticeBookModel(ApiResponse.completed(value));
    } catch (error) {
      setPracticeBookModel(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print("Error fetching data: $error");
      }
    }
  }

  ///GENERAL-KNOWLEDGE
  ApiResponse<GkModel> _gkResponse = ApiResponse.loading();

  ApiResponse<GkModel> get gkResponse => _gkResponse;

  void setGkModel(ApiResponse<GkModel> response) {
    if (_gkResponse != response) {
      _gkResponse = response;
      notifyListeners();
    }
  }

  Future<void> gkApi(context) async {
    setGkModel(ApiResponse.loading());
    try {
      final value = await _premiumRepo.gkApi();
      setGkModel(ApiResponse.completed(value));
    } catch (error) {
      setGkModel(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print("Error fetching data: $error");
      }
    }
  }

   ///LIBRARY///
  ///CLASS-HANGOUTS
  ApiResponse<ClassHangOutsModel> _classHandoutsResponse =
      ApiResponse.loading();

  ApiResponse<ClassHangOutsModel> get classHandoutsResponse =>
      _classHandoutsResponse;

  void setClassHandoutsModel(ApiResponse<ClassHangOutsModel> response) {
    if (_classHandoutsResponse != response) {
      _classHandoutsResponse = response;
      notifyListeners();
    }
  }

  Future<void> classHandOutApi(context) async {
    setClassHandoutsModel(ApiResponse.loading());
    try {
      final value = await _premiumRepo.classHandOutApi();
      setClassHandoutsModel(ApiResponse.completed(value));
    } catch (error) {
      setClassHandoutsModel(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print("Error fetching data: $error");
      }
    }
  }
  ///PREVIOUS-YEAR-PAPER
  ApiResponse<PreviousYearModel> _previousYearPaperResponse = ApiResponse.loading();

  ApiResponse<PreviousYearModel> get previousYearPaperResponse => _previousYearPaperResponse;

  void setPreviousYearPaperModel(ApiResponse<PreviousYearModel> response) {
    if (_previousYearPaperResponse != response) {
      _previousYearPaperResponse = response;
      notifyListeners();
    }
  }

  Future<void> previousYearPaperApi(context) async {
    setPreviousYearPaperModel(ApiResponse.loading());
    try {
      final value = await _premiumRepo.previousYearPaperApi();
      setPreviousYearPaperModel(ApiResponse.completed(value));
    } catch (error) {
      setPreviousYearPaperModel(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print("Error fetching data: $error");
      }
    }
  }

  ///B-SCHOOL-INFO
  ApiResponse<BSchoolInfoModel> _bSchoolInfoResponse = ApiResponse.loading();

  ApiResponse<BSchoolInfoModel> get bSchoolInfoResponse => _bSchoolInfoResponse;

  void setBSchoolInfoModel(ApiResponse<BSchoolInfoModel> response) {
    if (_bSchoolInfoResponse != response) {
      _bSchoolInfoResponse = response;
      notifyListeners();
    }
  }

  Future<void> bSchoolInfoApi(context) async {
    setBSchoolInfoModel(ApiResponse.loading());
    try {
      final value = await _premiumRepo.bSchoolInfoApi();
      setBSchoolInfoModel(ApiResponse.completed(value));
    } catch (error) {
      setBSchoolInfoModel(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print("Error fetching data: $error");
      }
    }
  }
}
