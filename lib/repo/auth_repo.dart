import 'package:flutter/foundation.dart';
import 'package:fundamakers/helper/network/base_api_services.dart';
import 'package:fundamakers/helper/network/network_api.dart';
import 'package:fundamakers/res/app_url.dart';

class AuthenticationRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
///OTP SENT
  Future<dynamic> otpSentApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiBearerResponse(AppUrls.sendOtpUrls,data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during otpSentApi: $e');
      }
      rethrow;
    }
  }
///OTP VERIFY
  Future<dynamic> verifyOtpApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiBearerResponse(AppUrls.verifyOtpUrls,data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during verifyOtpApi: $e');
      }
      rethrow;
    }
  }
///REGISTER
  Future<dynamic> registerApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiBearerResponse(AppUrls.registerUrls,data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during registerApi: $e');
      }
      rethrow;
    }
  }

}
