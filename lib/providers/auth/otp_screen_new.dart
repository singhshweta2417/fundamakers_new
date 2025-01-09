import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fundamakers/models/auth/auth_model.dart';
import 'package:fundamakers/providers/auth/userview_provider.dart';
import 'package:fundamakers/res/app_url.dart';
import 'package:fundamakers/utils/utils.dart';
import 'package:fundamakers/view/app/bottom_navigation_screen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class OtpScreenNewProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _randomBool = false;
  bool get randomBool => _randomBool;
  setRandomBool(bool value) {
    _randomBool = value;
    notifyListeners();
  }

  AuthModel? _loginResponse;

  AuthModel? get loginResponse => _loginResponse;


  UserViewModel userViewProvider = UserViewModel();

  Future sendOtpNewPhone(context, String phone) async {
    setRandomBool(true);
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
        setRandomBool(true);
        if (jsonResponse.containsKey('otp') && jsonResponse['otp'] != '') {
          print('Received OTP: ${jsonResponse['otp']}');
        } else {
          print('OTP not found or empty');
        }

        ShowMessages.showSuccessSnackBar(
          jsonResponse["success"],
          context,
        );
      } else {
        final jsonResponse = jsonDecode(response.body);
        setRandomBool(false);
        ShowMessages.showErrorSnackBar(
          jsonResponse["error"],
          context,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      setRandomBool(false);
      ShowMessages.showErrorSnackBar(
        'No Internet connection',
        context,
      );
    }
  }


  bool _verifyLoading = false;
  bool get verifyLoading => _verifyLoading;
  setVerifyLoading(bool value) {
    _verifyLoading = value;
    notifyListeners();
  }

  Future<void> verifyNewOtp(context, String phone, String otpCon) async {
    setRandomBool(true);
    setVerifyLoading(true);
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
          setVerifyLoading(false);
          final userPref =
              Provider.of<UserViewModel>(context, listen: false);
          userPref.saveUser(AuthModel(token: jsonResponse['token']));
          // _errorMessage = 'Verified successfully';
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const BottomNavigationPage()),
          );
          setRandomBool(false);
        } else {
          setRandomBool(false);
          setVerifyLoading(true);
          // _errorMessage = 'You are not registered yet,Please Register Yourself';
        }
      } else if (response.statusCode == 403) {
        setRandomBool(false);
        setVerifyLoading(false);
        // _errorMessage = jsonDecode(response.body)['message'];
      } else {
        setRandomBool(false);
        setVerifyLoading(false);
        throw Exception('Failed to verify OTP');
      }
    } catch (e) {
      setRandomBool(false);
      setVerifyLoading(false);
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
        // _errorMessage = 'Otp sent Successfully';
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
        // _errorMessage = jsonDecode(response.body)['message'];
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

  clear() {
    _verifyLoading = false;
    _randomBool = false;
    _loading = false;
    // _errorMessage = '';
    notifyListeners();
  }
}
