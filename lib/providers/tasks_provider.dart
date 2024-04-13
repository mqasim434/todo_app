import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/models/tasks_model.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/utils/consts.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class TaskProvider extends ChangeNotifier {
  int currentPage = 1;
  List<Todos> todosList = [];
  int limit = 10;

  Future<void> fetchTasksFromApi() async {
    EasyLoading.show(status: 'Fetching Todos');
    final response = await http.get(Uri.parse('$Todos_Base_Url/user/${UserModel.signedInUser.id}'));
    if (response.statusCode == 200) {
      todosList.addAll(TasksModel.fromJson(jsonDecode(response.body)).todos as Iterable<Todos>);
      notifyListeners();
    } else {
      // Handle error response
    }
    EasyLoading.dismiss();
  }

  Future<void> deleteTask(int id) async {
    EasyLoading.show(status: 'Deleting Todo');
    final response = await http.delete(Uri.parse('$Todos_Base_Url/${id-1}'));
    if (response.statusCode == 200) {
      print(response.body);
      EasyLoading.dismiss();
      notifyListeners();
    } else {
      EasyLoading.dismiss();
      throw Exception('Failed to delete tasks');
    }
  }

  void nextPage() {
    currentPage++;
    fetchTasksFromApi();
  }

  void previousPage() {
    currentPage--;
    fetchTasksFromApi();
  }
}
