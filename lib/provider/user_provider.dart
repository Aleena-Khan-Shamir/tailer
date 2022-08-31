import 'package:alma_app/authenticationHelper/authentication_helper.dart';
import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class UserProvider with ChangeNotifier {
  Userr? _user;
  final AuthenticationHelper _authMethods = AuthenticationHelper();

  Userr? get getUser => _user;

  UserProvider() {
    refreshUser();
  }

  Future<void> refreshUser() async {
    print('refreshUser is called');
    _user = await _authMethods.getUserDetails();

    notifyListeners();
  }
}
