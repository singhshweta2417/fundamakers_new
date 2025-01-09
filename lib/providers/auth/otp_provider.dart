import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fundamakers/models/auth/auth_model.dart';
import 'package:fundamakers/providers/auth/userview_provider.dart';
import 'package:fundamakers/res/app_url.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:fundamakers/utils/utils.dart';
import 'package:fundamakers/view/app/auth/register_screen_new.dart';
import 'package:fundamakers/view/app/bottom_navigation_screen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class OtpScreenProvider with ChangeNotifier {
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

  UserViewModel userViewProvider = UserViewModel();

  Future sendOtpOnPhone(context, String phone) async {
    setLoading(true);
    try {
      final response = await http
          .post(
            Uri.parse(AppUrls.sendOtpUrls),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"mobile_number": phone}),
          )
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        setLoading(false);
        Navigator.pushNamed(context, RoutesName.otpScreen,arguments: {"phone":phone});
        ShowMessages.showSuccessSnackBar(
          jsonResponse["success"],
          context,
        );
      } else if (response.statusCode == 500) {
        final jsonResponse = jsonDecode(response.body);
        setLoading(false);
        ShowMessages.showErrorSnackBar(
          jsonResponse["error"],
          context,
        );
      } else {
        setLoading(false);
        throw Exception('Failed to send otp');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      setLoading(false);
      throw Exception('No Internet connection');
    }
  }

  Future<void> verifyOtp(context, String phone, String otpCon) async {
    setLoading(true);
    try {
      final response = await http
          .post(
            Uri.parse(AppUrls.verifyOtpUrls),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "mobile_number": phone,
              "otp": otpCon,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse.containsKey('token')) {
          setLoading(false);
          final userPref =
              Provider.of<UserViewModel>(context, listen: false);
          userPref.saveUser(AuthModel(token: jsonResponse['token']));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const BottomNavigationPage()),
          );
        } else {
          setLoading(false);
          _errorMessage = 'You are not registered yet';
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const RegisterScreenNew()),
          );
        }
      } else if (response.statusCode == 403) {
        setLoading(false);
        _errorMessage = jsonDecode(response.body)['message'];
      } else {
        setLoading(false);
        throw Exception('Failed to verify OTP');
      }
    } catch (e) {
      setLoading(false);
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception(
          'Failed to verify OTP. Please check your internet connection and try again.');
    }
  }

  Future sendOtpOnRegister(context, String mobileCon) async {
    setLoading(true);
    try {
      final response = await http
          .post(
            Uri.parse(AppUrls.sendOtpUrls),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"mobile_number": mobileCon}),
          )
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        setLoading(false);
        _errorMessage = 'Otp sent Successfully';
      } else {
        setLoading(false);
        throw Exception('Failed to send otp');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      setLoading(false);
      throw Exception('No Internet connection');
    }
  }

  Future<void> verifyRegisterOtp(
      context, String phoneCon, String otpCont) async {
    setLoading(true);
    try {
      final response = await http
          .post(
            Uri.parse(AppUrls.verifyOtpUrls),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "mobile_number": phoneCon,
              "otp": otpCont,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse.containsKey('token')) {
          setLoading(false);
          final userPref =
              Provider.of<UserViewModel>(context, listen: false);
          userPref.saveUser(AuthModel(token: jsonResponse['token']));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const BottomNavigationPage()),
          );
        } else {
          setLoading(false);
        }
      } else if (response.statusCode == 403) {
        setLoading(false);
        _errorMessage = jsonDecode(response.body)['message'];
      } else {
        setLoading(false);
        throw Exception('Failed to verify OTP');
      }
    } catch (e) {
      setLoading(false);
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception(
          'Failed to verify OTP. Please check your internet connection and try again.');
    }
  }
}
