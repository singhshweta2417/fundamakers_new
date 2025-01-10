import 'package:flutter/material.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:fundamakers/view/app/auth/login_screen.dart';
import 'package:fundamakers/view/app/auth/otp_screen.dart';
import 'package:fundamakers/view/app/auth/register_screen.dart';
import 'package:fundamakers/view/app/bottom_navigation_screen.dart';
import 'package:fundamakers/view/app/profile/user_details_screen.dart';
import 'package:fundamakers/view/splash_screen.dart';

class Routers {
  static WidgetBuilder generateRoute(String routeName) {
    switch (routeName) {
      case RoutesName.splashScreen:
        return (context) => const SplashScreen();
      case RoutesName.otpScreen:
        return (context) => const OtpScreen();
      case RoutesName.registerScreen:
        return (context) => const RegisterScreen();
      case RoutesName.loginScreen:
        return (context) => const LoginScreen();
      case RoutesName.bottomNavigationBar:
        return (context) => const BottomNavigationPage();
      case RoutesName.userDetailsScreen:
        return (context) => const UserDetailsScreen();
      default:
        return (context) => const Scaffold(
              body: Center(
                child: Text(
                  'No Route Found!',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
            );
    }
  }
}
