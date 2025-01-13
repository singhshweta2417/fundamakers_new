import 'package:flutter/foundation.dart';
import 'package:fundamakers/helper/response/api_response.dart';
import 'package:fundamakers/models/test/test_list_model.dart';
import 'package:fundamakers/models/test_model.dart';
import 'package:fundamakers/models/test_type_details_model.dart';
import 'package:fundamakers/repo/test_type_details_repo.dart';

class TestTypeViewModel with ChangeNotifier {
  final _testTypeDetailsRepo = TestTypeDetailsRepository();

  ///TEST-LISTS
  ApiResponse<TestListModel> _testListResponse = ApiResponse.loading();

  ApiResponse<TestListModel> get testListResponse => _testListResponse;

  void setTestListModel(ApiResponse<TestListModel> response) {
    if (_testListResponse != response) {
      _testListResponse = response;
      notifyListeners();
    }
  }

  Future<void> testListApi(context) async {
    setTestListModel(ApiResponse.loading());
    try {
      final value = await _testTypeDetailsRepo.testTypeListApi();
      setTestListModel(ApiResponse.completed(value));
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching data: $error");
      }
    }
  }

  ///TEST TYPE DETAILS

  ApiResponse<TestTypeDetailsModel> _testTypeDetailsResponse =
      ApiResponse.loading();

  ApiResponse<TestTypeDetailsModel> get testTypeDetailsResponse =>
      _testTypeDetailsResponse;

  void setTestTypeDetailsModel(ApiResponse<TestTypeDetailsModel> response) {
    if (_testTypeDetailsResponse != response) {
      _testTypeDetailsResponse = response;
      notifyListeners();
    }
  }

  Future<void> testTypeDetailApi(dynamic data, context) async {
    setTestTypeDetailsModel(ApiResponse.loading());
    try {
      final value = await _testTypeDetailsRepo.testTypeDetailApi(data);
      setTestTypeDetailsModel(ApiResponse.completed(value));
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching data: $error");
      }
    }
  }

  ///TEST

  ApiResponse<TestModel> _testResponse = ApiResponse.loading();

  ApiResponse<TestModel> get testResponse => _testResponse;

  void setTestModel(ApiResponse<TestModel> response) {
    if (_testResponse != response) {
      _testResponse = response;
      notifyListeners();
    }
  }

  Future<void> testApi(context) async {
    setTestModel(ApiResponse.loading());
    try {
      final value = await _testTypeDetailsRepo.testApi();
      setTestModel(ApiResponse.completed(value));
    } catch (error) {
      setTestModel(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print("Error fetching data: $error");
      }
    }
  }
}
