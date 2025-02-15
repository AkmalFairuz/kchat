import 'package:flutter/material.dart';
import 'package:kchat/local_storage.dart';
import 'package:kchat/model/user.dart';
import 'package:provider/provider.dart';

class GlobalState extends ChangeNotifier {
  bool _darkMode = false;
  String _token = '';
  User? _loggedUser;

  bool get darkMode => _darkMode;
  String get token => _token;
  User? get loggedUser => _loggedUser;

  void toggleDarkMode() {
    _darkMode = !_darkMode;
    notifyListeners();
  }

  static bool isDarkMode(BuildContext context) {
    return Provider.of<GlobalState>(context, listen: false).darkMode;
  }

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  static String getToken(BuildContext context) {
    return Provider.of<GlobalState>(context, listen: false).token;
  }

  void setLoggedUser(User user) {
    _loggedUser = user;
    LocalStorage.saveString("Token", _token);
    notifyListeners();
  }

  static User? getLoggedUser(BuildContext context) {
    return Provider.of<GlobalState>(context, listen: false)._loggedUser;
  }
}
