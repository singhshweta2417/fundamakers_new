import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fundamakers/models/auth/auth_model.dart';
import 'package:fundamakers/providers/auth/userview_provider.dart';
import 'package:fundamakers/res/app_url.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginProvider with ChangeNotifier {
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

  setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> userLogin(context, String phoneNumber, String password) async {
    setLoading(true);
    try {
      final response = await http.post(
        Uri.parse(AppUrls.loginUrls),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"mobile_number": phoneNumber}),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        _loginResponse = AuthModel.fromJson(responseData);
        final userPref = Provider.of<UserViewModel>(context, listen: false);
        userPref.saveUser(AuthModel(token: _loginResponse!.token));
        Navigator.pushNamed(context, RoutesName.otpScreen,arguments: {"phone":phoneNumber});
      } else {
        _errorMessage = responseData['message'] ??
            '● You could not be logged in. Try to reset your password';
      }
    } catch (error) {
      _errorMessage = 'An error occurred:';
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }
}
