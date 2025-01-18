import 'package:flutter/foundation.dart';
import 'package:fundamakers/helper/response/api_response.dart';
import 'package:fundamakers/models/concepts_model.dart';
import 'package:fundamakers/repo/notes_ebooks_repo.dart';

class ConceptsViewModel with ChangeNotifier {
  final _conceptsRepo = NotesEbooksRepository();

  ///ConceptsSubject
  ApiResponse<ConceptsModel> _conceptsResponse = ApiResponse.loading();

  ApiResponse<ConceptsModel> get conceptsResponse => _conceptsResponse;

  void setConceptsModel(ApiResponse<ConceptsModel> response) {
    if (_conceptsResponse != response) {
      _conceptsResponse = response;
      notifyListeners();
    }
  }

  Future<void> notesEbookApi(dynamic data, context) async {
    setConceptsModel(ApiResponse.loading());
    try {
      final value = await _conceptsRepo.notesEbookApi(data);
      setConceptsModel(ApiResponse.completed(value));
    } catch (error) {
      setConceptsModel(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print("Error fetching data: $error");
      }
    }
  }
}
