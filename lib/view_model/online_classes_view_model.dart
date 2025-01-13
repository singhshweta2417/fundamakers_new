import 'package:flutter/foundation.dart';
import 'package:fundamakers/helper/response/api_response.dart';
import 'package:fundamakers/models/online_classes_model.dart';
import 'package:fundamakers/repo/online_classes_repo.dart';

class OnlineClassesViewModel with ChangeNotifier {
  final _onlineClassesRepo = OnlineClassesRepository();

  ///ONLINE-CLASSES
  ApiResponse<OnlineClassesModel> _onlineClassesResponse = ApiResponse.loading();

  ApiResponse<OnlineClassesModel> get onlineClassesResponse =>
      _onlineClassesResponse;

  void setOnlineClassesModel(ApiResponse<OnlineClassesModel> response) {
    if (_onlineClassesResponse != response) {
      _onlineClassesResponse = response;
      notifyListeners();
    }
  }

  Future<void> onlineClassesApi(context) async {
    setOnlineClassesModel(ApiResponse.loading());
    try {
      final value = await _onlineClassesRepo.onlineClassesApi();
      setOnlineClassesModel(ApiResponse.completed(value));
    } catch (error) {
      setOnlineClassesModel(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print("Error fetching data: $error");
      }
    }
  }
}
