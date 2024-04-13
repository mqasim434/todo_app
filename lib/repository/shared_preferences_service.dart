import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/tasks_model.dart';
import 'package:todo_app/models/user_model.dart';

class SharedPreferencesServices {
  static Future<void> saveTodosLocally(List<Todos> todosList) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final jsonData =
    todosList.map((e) => jsonEncode(e.toJson())).toList();

    await sharedPreferences.setStringList('todos', jsonData.cast<String>());
  }

  static Future<List<Todos>> getTodosLocally() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final jsonData = sharedPreferences.getStringList('todos');

    if (jsonData == null) {
      return [];
    }

    List<Todos> todosList = jsonData.map((e) => Todos.fromJson(jsonDecode(e))).toList();

    return todosList;
  }


  static Future<void> saveUserLocally(UserModel userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final jsonData = jsonEncode(userModel);

    await sharedPreferences.setString('user-data', jsonData);
  }

  static Future<void> getUserLocally() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonData = sharedPreferences.getString('user-data');
    UserModel.signedInUser = UserModel.fromJson(jsonDecode(jsonData!));
  }


  static Future<void> clearPreferences()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  static Future<void> saveToken(String token)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('user-token', token);
  }

  static Future<bool> hasToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('user-token');
  }

}
