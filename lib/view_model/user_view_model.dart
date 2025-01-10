import 'package:flutter/cupertino.dart';
import 'package:fundamakers/models/auth/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {

  //set user token
  Future<bool> saveUser(AuthModel user) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.token.toString());
    notifyListeners();
    return true;
  }

//get user token
  Future<AuthModel> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    if (token != null) {
      return AuthModel(token: token);
    } else {
      return AuthModel(token: null);
    }
  }


//remove user token
  Future<bool> remove() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    return true;
  }
}
