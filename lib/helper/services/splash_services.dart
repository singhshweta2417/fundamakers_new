import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fundamakers/models/auth/auth_model.dart';
import 'package:fundamakers/view_model/user_view_model.dart';
import 'package:fundamakers/view/app/auth/login_screen.dart';
import 'package:fundamakers/view/app/bottom_navigation_screen.dart';

class SplashServices {
  //sharedPreferences get hua hai
  Future<AuthModel> getUserData() => UserViewModel().getUser();
  void checkAuthentication(context) async {
    getUserData().then((value) async {
      if (kDebugMode) {
        print(value.token);
        print('valueId');
      }
      if (value.token == null || value.token=='' ) {
        await Future.delayed(const Duration(seconds: 5));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
      } else {
        await Future.delayed(const Duration(seconds: 5));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const BottomNavigationPage()));
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
