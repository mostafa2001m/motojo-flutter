import 'dart:convert';

import 'package:motojo/src/features/authentication/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String keyCurrentUser = 'current_user';

  static Future<void> saveCurrentUser(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(keyCurrentUser, json.encode(user.toMap()));
  }

  static Future<Map?> getCurrentUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userString = prefs.getString(keyCurrentUser);

    if (userString != null) {
      final Map<String, dynamic> userMap = json.decode(userString);
      return userMap;
    }

    return null;
  }
}
