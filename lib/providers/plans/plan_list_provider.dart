// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fundamakers/models/auth/auth_model.dart';
import 'package:fundamakers/models/plans/plan_list_model.dart';
import 'package:fundamakers/view_model/user_view_model.dart';
import 'package:fundamakers/res/app_url.dart';
import 'package:http/http.dart' as http;

class PlanListProvider with ChangeNotifier {
  List<PlanListModel> _planList = [];

  List<PlanListModel> get testList => _planList;

  void setPlanList(List<PlanListModel> planLists) {
    _planList = planLists;
    notifyListeners();
  }
  UserViewModel userViewModel = UserViewModel();
  Future<List<PlanListModel>> fetchPlanListData(String subCourseId) async {
    AuthModel authModel = await userViewModel.getUser();
    String userToken = authModel.token.toString();
    try {
      final response = await http.get(
        Uri.parse('${AppUrls.plansUrls}sub_course_id=$subCourseId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $userToken',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> jsonData = jsonResponse["data"];
        List<PlanListModel> planList = jsonData
            .map((jsonMap) => PlanListModel.fromJson(jsonMap))
            .toList();

        return planList;

      } else {
        throw Exception(
            'Failed to load subjects data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception(
          'Failed to fetch subjects data. Check your internet connection.');
    }
  }
}

