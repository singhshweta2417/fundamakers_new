// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fundamakers/models/auth/auth_model.dart';
import 'package:fundamakers/models/library/class_hangouts_model.dart';
import 'package:fundamakers/providers/auth/userview_provider.dart';
import 'package:fundamakers/res/app_url.dart';
import 'package:http/http.dart' as http;

class HanOutsProvider with ChangeNotifier {
  List<ClassHangOutsModel> _classHangOutsList = [];

  List<ClassHangOutsModel> get classHangOutsList => _classHangOutsList;

  void setClassHandoutsList(List<ClassHangOutsModel> classHangOutsList) {
    _classHangOutsList = classHangOutsList;
    notifyListeners();
  }
  UserViewModel userViewModel = UserViewModel();
  Future<List<ClassHangOutsModel>> fetchClassHandOutsData() async {
    AuthModel authModel = await userViewModel.getUser();
    String userToken = authModel.token.toString();
    try {
      final response = await http.get(
        Uri.parse(AppUrls.classHandoutsUrls),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $userToken',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> jsonData = jsonResponse["data"];
        List<ClassHangOutsModel> gkZoneList = jsonData
            .map((jsonMap) => ClassHangOutsModel.fromJson(jsonMap))
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

