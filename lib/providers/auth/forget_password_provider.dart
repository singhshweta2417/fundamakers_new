// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fundamakers/models/auth/auth_model.dart';
// import 'package:fundamakers/res/app_url.dart';
// import 'package:fundamakers/view/app/auth/login_screen.dart';
// import 'package:http/http.dart' as http;
//
// class ChangePasswordProvider with ChangeNotifier {
//   bool _loading = false;
//   bool get loading => _loading;
//
//   void setLoading(bool value) {
//     _loading = value;
//     notifyListeners();
//   }
//
//   AuthModel? _loginResponse;
//   AuthModel? get loginResponse => _loginResponse;
//
//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;
//
//   Future<void> userChangePassword(
//     BuildContext context,
//     String password,
//     String cPassword,
//   ) async {
//     setLoading(true);
//     try {
//       final response = await http.post(
//         Uri.parse(AppUrls.changePasswordUrls),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({
//           "password": password,
//           "c_password": cPassword,
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         setLoading(false);
//         _errorMessage = '● Password changed successfully';
//       } else if (response.statusCode == 422) {
//         setLoading(false);
//         _errorMessage = '● The Confirm password field must match the password';
//       } else {
//         setLoading(false);
//         _errorMessage = '● Server Error';
//       }
//     } catch (e) {
//       setLoading(false);
//       _errorMessage = 'Error: $e';
//     }
//     notifyListeners();
//     if (_errorMessage == '● Password changed successfully') {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const LoginScreen(),
//         ),
//       );
//     }
//   }
// }
