import 'package:flutter/foundation.dart';
import 'package:fundamakers/helper/response/api_response.dart';
import 'package:fundamakers/models/subjects/subject_model.dart';
import 'package:fundamakers/repo/subject_repo.dart';

class SubjectViewModel with ChangeNotifier {
  final _subjectRepo = SubjectRepository();
  ApiResponse<SubjectModel> _subjectResponse = ApiResponse.loading();

  ApiResponse<SubjectModel> get subjectResponse => _subjectResponse;

  void setSubjectModel(ApiResponse<SubjectModel> response) {
    if (_subjectResponse != response) {
      _subjectResponse = response;
      notifyListeners();
    }
  }

  Future<void> subjectApi(context) async {
    setSubjectModel(ApiResponse.loading());
    try {
      final value = await _subjectRepo.subjectApi();
      setSubjectModel(ApiResponse.completed(value));
    } catch (error) {
      setSubjectModel(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print("Error fetching data: $error");
      }
    }
  }
}
