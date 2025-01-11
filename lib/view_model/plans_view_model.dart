import 'package:flutter/foundation.dart';
import 'package:fundamakers/helper/response/api_response.dart';
import 'package:fundamakers/models/plans/plan_list_model.dart';
import 'package:fundamakers/repo/plans_repo.dart';

class PlansViewModel with ChangeNotifier {
  final _plansRepo = PlansRepository();
  ApiResponse<PlansListModel> _plansResponse = ApiResponse.loading();

  ApiResponse<PlansListModel> get plansResponse => _plansResponse;

  void setPlansModel(ApiResponse<PlansListModel> response) {
    if (_plansResponse != response) {
      _plansResponse = response;
      notifyListeners();
    }
  }

  Future<void> plansApi(dynamic data, context) async {
    setPlansModel(ApiResponse.loading());
    try {
      final value = await _plansRepo.planApi(data);
      setPlansModel(ApiResponse.completed(value));
    } catch (error) {
      setPlansModel(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print("Error fetching data: $error");
      }
    }
  }
}
