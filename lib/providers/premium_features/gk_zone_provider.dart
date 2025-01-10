// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fundamakers/models/auth/auth_model.dart';
import 'package:fundamakers/models/premium_features_model/gk_zone_model.dart';
import 'package:fundamakers/view_model/user_view_model.dart';
import 'package:fundamakers/res/app_url.dart';
import 'package:http/http.dart' as http;

class GkZoneProvider with ChangeNotifier {
  List<GkZoneModel> _gkZoneList = [];

  List<GkZoneModel> get gkZoneList => _gkZoneList;

  void setGkZoneList(List<GkZoneModel> gkZoneLists) {
    _gkZoneList = gkZoneLists;
    notifyListeners();
  }
  UserViewModel userViewModel = UserViewModel();
  Future<List<GkZoneModel>> fetchGkZoneData() async {
    AuthModel authModel = await userViewModel.getUser();
    String userToken = authModel.token.toString();
    try {
      final response = await http.get(
        Uri.parse(AppUrls.gkUrls),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $userToken',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> jsonData = jsonResponse["data"];
        List<GkZoneModel> gkZoneList = jsonData
            .map((jsonMap) => GkZoneModel.fromJson(jsonMap))
            .toList();
        return gkZoneList;
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

