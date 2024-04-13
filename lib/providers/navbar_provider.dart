import 'package:flutter/material.dart';
import 'package:todo_app/views/home_screen.dart';
import 'package:todo_app/views/profile_screen.dart';
import 'package:todo_app/views/tasks_screen.dart';

class BottomNavbarProvider extends ChangeNotifier{
  int _selectedIndex = 0;
  final PageController _controller = PageController();

  int get selectedIndex => _selectedIndex;
  PageController get controller => _controller;

  var screensList = [
    const HomeScreen(),
    const TasksScreen(),
    const ProfileScreen(),
  ];

  void changeIndex(int index){
    _selectedIndex = index;
    controller.animateToPage(index, duration: const Duration(milliseconds: 1), curve: Curves.easeInOut,);
    notifyListeners();
  }
}