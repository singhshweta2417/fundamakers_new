import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fundamakers/models/auth/auth_model.dart';
import 'package:fundamakers/res/app_url.dart';
import 'package:fundamakers/view/app/bottom_navigation_screen.dart';
import 'package:http/http.dart' as http;

class RegistrationNewProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  AuthModel? _loginResponse;

  AuthModel? get loginResponse => _loginResponse;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> userNewRegister(
      context,
      String email,
      String firstName,
      String mobileNumber,
      String courseId,
      String subCourseId,
      String lastName,
      ) async {
    setLoading(true);
    try {
      final response = await http.post(
        Uri.parse(AppUrls.registerUrls),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "first_name": firstName,
          "mobile_number": mobileNumber,
          "course_id": courseId,
          "sub_course_id": subCourseId,
          "last_name": lastName,
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['success'] == true){
          setLoading(false);
          _errorMessage = responseData["error"] ?? '● Registration Failed';
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavigationPage(),
            ),
          );
        } else {
          setLoading(false);
          _errorMessage = responseData["error"] ?? '● Registration Failed';
        }
      } else if (response.statusCode == 422) {
        setLoading(false);
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        _errorMessage = responseData["error"] ?? '● Mobile Number already registered';
      } else {
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
    }
  }
}
