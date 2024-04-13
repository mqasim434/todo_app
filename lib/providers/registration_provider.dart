import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/repository/shared_preferences_service.dart';
import 'package:todo_app/utils/consts.dart';
import 'package:todo_app/models/user_model.dart';

class RegistrationProvider extends ChangeNotifier {
  
  Future<void> signInWithEmail(String email, String password) async {
    EasyLoading.show(status: 'Logging in');
    final response = await http.post(
      Uri.parse(
        Auth_End_Point_Url,
      ),
      body: {
        'username' : email,
        'password': password,
      }
    );
    if(response.statusCode==200){
      await SharedPreferencesServices.saveUserLocally(UserModel.fromJson(jsonDecode(response.body)));
      await SharedPreferencesServices.getUserLocally();
    }
    EasyLoading.dismiss();
  }
}
