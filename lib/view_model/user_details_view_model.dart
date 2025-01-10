import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fundamakers/models/user_details_model.dart';
import 'package:fundamakers/repo/update_profile_details_repo.dart';
import 'package:fundamakers/utils/utils.dart';

class UserDetailViewModel with ChangeNotifier {
  final _userDetailRepo = UserDetailRepository();

  bool _userDetailLoading = false;

  bool get userDetailLoading => _userDetailLoading;

  setUserDetailLoading(bool value) {
    _userDetailLoading = value;
    notifyListeners();
  }

  UserDetailsModel? _userDetailsResponse;
  UserDetailsModel? get userDetailsResponse => _userDetailsResponse;
  ErrorModel? _errorResponse;
  ErrorModel? get errorResponse => _errorResponse;

  setUserDetailsModel(UserDetailsModel shweta) {
    _userDetailsResponse = shweta;
    notifyListeners();
  }

  setErrorUserModel(ErrorModel errorUser) {
    _errorResponse = errorUser;
    notifyListeners();
  }

  Future<void> userDetailsApi(
      dynamic firstName, dynamic lastName, context) async {
    setUserDetailLoading(true);
    Map<String, dynamic> data = {
      "first_name": firstName,
      "last_name": lastName,
    };

    try {
      final value = await _userDetailRepo.userDetailsApi(data);
      setUserDetailLoading(false);
      final userDetails = UserDetailsModel.fromJson(value);
      setUserDetailsModel(userDetails);
      ShowMessages.showSuccessSnackBar(
          'User details retrieved successfully!', context);
    } catch (error) {
      setUserDetailLoading(false);
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
            if (errors['last_name'] != null) {
              errorMessage += '${errors['last_name'][0]}\n';
            }
            ShowMessages.showErrorSnackBar(errorMessage.trim(), context);
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

  Future<void> getUserDetailsApi(context) async {
    try {
      final value = await _userDetailRepo.getUserDetailsApi();
      setUserDetailLoading(false);
      final userDetails = UserDetailsModel.fromJson(value);
      setUserDetailsModel(userDetails);
    } catch (error) {}
  }
}
