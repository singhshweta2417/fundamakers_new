import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fundamakers/models/auth/auth_model.dart';
import 'package:fundamakers/view_model/user_view_model.dart';
import 'package:fundamakers/repo/auth_repo.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:fundamakers/utils/utils.dart';
import 'package:provider/provider.dart';

class AuthenticationViewModel with ChangeNotifier {
  final _authRepo = AuthenticationRepository();


  ///SENT OTP
  bool _otpLoading = false;
  bool get otpLoading => _otpLoading;

  setOtpLoading(bool value) {
    _otpLoading = value;
    notifyListeners();
  }

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> otpSentApi(dynamic phoneNumber, context) async {
    setOtpLoading(true);
    Map data = {"mobile_number": phoneNumber};
    try {
      final value = await _authRepo.otpSentApi(data);
      setOtpLoading(false);
      Navigator.pushNamed(context, RoutesName.otpScreen,
          arguments: {"phone": phoneNumber.toString()});
      ShowMessages.showSuccessSnackBar(
        value["success"],
        context,
      );
    } catch (error) {
      setOtpLoading(false);
      try {
        final errorString = error.toString();
        final jsonStartIndex = errorString.indexOf('{');
        if (jsonStartIndex != -1) {
          final jsonPart = errorString.substring(jsonStartIndex);
          final parsedError = jsonDecode(jsonPart);
          if (parsedError is Map && parsedError.containsKey('error')) {
            final errors = parsedError['error'];
            if (errors is Map && errors.containsKey('mobile_number')) {
              setOtpLoading(false);
              String errorMessage = '';
              if (errors['mobile_number'] != null) {
                errorMessage += '${errors['mobile_number'][0]}\n';
              }
              _errorMessage = errorMessage.trim();
            } else if (errors is String) {
              setOtpLoading(false);
              _errorMessage = errors.toString();
            }
          }
        }
      } catch (e) {
        setOtpLoading(false);
        if (kDebugMode) {
          print('Error parsing the response: $e');
        }
      }
    }
  }


  ///VERIFY OTP
  bool _verifyLoading = false;
  bool get verifyLoading => _verifyLoading;

  setVerifyLoading(bool value) {
    _verifyLoading = value;
    notifyListeners();
  }
  String? _verifyMessage;
  String? get verifyMessage => _verifyMessage;
  Future<void> verifyOtpApi(
      dynamic phoneNumber, dynamic otpCon, context) async
  {
    setVerifyLoading(true);
    Map data = {"mobile_number": phoneNumber, "otp": otpCon};
    try {
      final value = await _authRepo.verifyOtpApi(data);
      setVerifyLoading(false);
      if(value["success"]==true){
        setVerifyLoading(false);
        value["token"];
        final userPref =
        Provider.of<UserViewModel>(context, listen: false);
        userPref.saveUser(AuthModel(token: value['token']));
        Navigator.pushNamed(context, RoutesName.bottomNavigationBar);
      }else{
        setVerifyLoading(false);
        Navigator.pushNamed(context, RoutesName.registerScreen);
      }
    } catch (error) {
      setVerifyLoading(false);
      try {
        final errorString = error.toString();
        final jsonStartIndex = errorString.indexOf('{');
        if (jsonStartIndex != -1) {
          final jsonPart = errorString.substring(jsonStartIndex);
          final parsedError = jsonDecode(jsonPart);
          if (parsedError is Map && parsedError.containsKey('error')) {
            final errors = parsedError['error'];
            if (errors is Map && errors.containsKey('otp')) {
              setVerifyLoading(false);
              String errorMessage = '';
              if (errors['otp'] != null) {
                errorMessage += '${errors['otp'][0]}\n';
              }
              _verifyMessage = errorMessage.trim();
            } else if (errors is String) {
              setVerifyLoading(false);
              _verifyMessage = errors.toString();
            }
          }
        }
      } catch (e) {
        setVerifyLoading(false);
        if (kDebugMode) {
          print('Error parsing the response: $e');
        }
      }
    }
  }

  ///NEW REGISTER SCREEN

  ///SENT NEW OTP
  bool _otpNewLoading = false;
  bool get otpNewLoading => _otpNewLoading;

  setOtpNewLoading(bool value) {
    _otpNewLoading = value;
    notifyListeners();
  }
  bool _setViewField = false;
  bool get setViewField => _setViewField;

  setView(bool value) {
    _setViewField = value;
    notifyListeners();
  }
  String? _errorNewMessage;
  String? get errorNewMessage => _errorNewMessage;

  Future<void> otpNewSentApi(dynamic phoneNumber, context) async {
    setOtpNewLoading(true);
    setView(true);
    Map data = {"mobile_number": phoneNumber};
    try {
      final value = await _authRepo.otpSentApi(data);
      setOtpNewLoading(false);
      ShowMessages.showSuccessSnackBar(
        value["success"],
        context,
      );
      setView(true);
    } catch (error) {
      setOtpNewLoading(false);
      try {
        final errorString = error.toString();
        final jsonStartIndex = errorString.indexOf('{');
        if (jsonStartIndex != -1) {
          final jsonPart = errorString.substring(jsonStartIndex);
          final parsedError = jsonDecode(jsonPart);
          if (parsedError is Map && parsedError.containsKey('error')) {
            final errors = parsedError['error'];
            if (errors is Map && errors.containsKey('mobile_number')) {
              setOtpNewLoading(false);
              setView(false);
              String errorMessage = '';
              if (errors['mobile_number'] != null) {
                errorMessage += '${errors['mobile_number'][0]}\n';
              }
              _errorNewMessage = errorMessage.trim();
            } else if (errors is String) {
              setOtpNewLoading(false);
              setView(false);
              _errorNewMessage = errors.toString();
            }
          }
        }
      } catch (e) {
        setOtpNewLoading(false);
        setView(true);
        if (kDebugMode) {
          print('Error parsing the response: $e');
        }
      }
    }
  }

  ///VERIFY NEW OTP
  bool _verifyNewLoading = false;
  bool get verifyNewLoading => _verifyNewLoading;

  setVerifyNewLoading(bool value) {
    _verifyNewLoading = value;
    notifyListeners();
  }
  String? _verifyNewMessage;
  String? get verifyNewMessage => _verifyNewMessage;
  Future<void> verifyNewOtpApi(
      dynamic phoneNumber, dynamic otpCon, context) async
  {
    setVerifyNewLoading(true);
    setView(true);
    Map data = {"mobile_number": phoneNumber, "otp": otpCon};
    try {
      final value = await _authRepo.verifyOtpApi(data);
      setVerifyNewLoading(false);
      setView(false);
      if(value["success"]==true){
        setVerifyLoading(false);
        setView(true);
        value["token"];
        final userPref =
        Provider.of<UserViewModel>(context, listen: false);
        userPref.saveUser(AuthModel(token: value['token']));
        Navigator.pushNamed(context, RoutesName.bottomNavigationBar);
      }
    } catch (error) {
      setVerifyNewLoading(false);
      try {
        final errorString = error.toString();
        final jsonStartIndex = errorString.indexOf('{');
        if (jsonStartIndex != -1) {
          final jsonPart = errorString.substring(jsonStartIndex);
          final parsedError = jsonDecode(jsonPart);
          if (parsedError is Map && parsedError.containsKey('error')) {
            final errors = parsedError['error'];
            if (errors is Map && errors.containsKey('otp')) {
              setVerifyNewLoading(false);
              setView(false);
              String errorMessage = '';
              if (errors['otp'] != null) {
                errorMessage += '${errors['otp'][0]}\n';
              }
              _verifyMessage = errorMessage.trim();
              Navigator.pop(context);
            } else if (errors is String) {
              setVerifyNewLoading(false);
              setView(false);
              _verifyMessage = errors.toString();
              Navigator.pop(context);
            }
          }
        }
      } catch (e) {
        setVerifyNewLoading(false);
        setView(false);
        if (kDebugMode) {
          print('Error parsing the response: $e');
        }
      }
    }
  }
  ///NEW REGISTER

  bool _regLoading = false;
  bool get regLoading => _regLoading;
  setRegisterLoading(bool value) {
    _regLoading = value;
    notifyListeners();
  }
  String? _regMessage;
  String? get regMessage => _regMessage;
  Future<void> registerApi(  dynamic email,
      dynamic firstName,
      dynamic mobileNumber,
      dynamic courseId,
      dynamic subCourseId,
      dynamic lastName, context) async
  {
    setRegisterLoading(true);
    Map<String, dynamic> data = {
      "email": email,
      "first_name": firstName,
      "mobile_number": mobileNumber,
      "course_id": courseId,
      "sub_course_id": subCourseId,
      "last_name": lastName,
    };

    try {
      final value = await _authRepo.registerApi(data);
      setRegisterLoading(false);
     if(value['success'] == true){
       value["token"];
       final userPref =
       Provider.of<UserViewModel>(context, listen: false);
       userPref.saveUser(AuthModel(token: value['token']));
       Navigator.pushNamed(context, RoutesName.bottomNavigationBar);
     }
    } catch (error) {
      setRegisterLoading(false);
      try {
        final errorString = error.toString();
        final jsonStartIndex = errorString.indexOf('{');
        if (jsonStartIndex != -1) {
          final jsonPart = errorString.substring(jsonStartIndex);
          final parsedError = jsonDecode(jsonPart);

          if (parsedError is Map && parsedError.containsKey('error')) {
            final errors = parsedError['error'];
            String errorMessage = '';
            if (errors['first_name'] != null) {
              errorMessage += '${errors['first_name'][0]}\n';
            }
            if (errors['mobile_number'] != null) {
              errorMessage += '${errors['mobile_number'][0]}\n';
            }
            _regMessage=errorMessage.trim();
            return;
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to parse error response.')),
        );
      }
    }
  }

  void clearErrors() {
    _errorMessage = null;
    _verifyMessage = null;
    _errorNewMessage = null;
    _verifyNewMessage = null;
    _regMessage = null;
    notifyListeners();
  }

}
