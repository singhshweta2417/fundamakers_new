import 'package:flutter/material.dart';
import 'package:fundamakers/models/test_type_details_model.dart';
import 'package:fundamakers/repo/test_type_details_repo.dart';

class TestTypeViewModel with ChangeNotifier {
  final _testTypeDetailsRepo = TestTypeDetailsRepository();

  TestTypeDetailsModel? _testTypeDetailsResponse;
  TestTypeDetailsModel? get testTypeDetailsResponse => _testTypeDetailsResponse;

  setTestTypeDetailsModel(TestTypeDetailsModel shweta) {
    _testTypeDetailsResponse = shweta;
    notifyListeners();
  }
  clearTestTypeDetailsModel() {
    _testTypeDetailsResponse = null;
    notifyListeners();
  }
  Future<void> testTypeDetailApi(dynamic data, context) async {
    try {
      final value = await _testTypeDetailsRepo.testTypeDetailApi(data);
      final testTypeDetails = TestTypeDetailsModel.fromJson(value);
      setTestTypeDetailsModel(testTypeDetails);
    } catch (error) {
      print("Error fetching data: $error");
    }
  }
}
