import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/navbar_provider.dart';
import 'package:todo_app/providers/tasks_provider.dart';
import 'package:todo_app/widgets/bottom_navbar.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final BottomNavbarProvider navProvider = Provider.of<BottomNavbarProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: navProvider.controller,
          children: navProvider.screensList,
        ),
        bottomNavigationBar: MyNavBar(
          backgroundColor: Colors.deepPurple,
          navItems: [
            NavItem(
              label: 'Home',
              activeIcon: Icons.home,
              inActiveIcon: Icons.home_outlined,
              index: 0,
              onTap: () {
                navProvider.changeIndex(0);
              },
            ),NavItem(
              label: 'Tasks',
              activeIcon: Icons.task,
              inActiveIcon: Icons.task_outlined,
              index: 1,
              onTap: () {
                navProvider.changeIndex(1);
              },
            ),NavItem(
              label: 'Profile',
              activeIcon: Icons.person,
              index: 2,
              inActiveIcon: Icons.person_outline,
              onTap: () {
                navProvider.changeIndex(2);
              },
            ),
          ],
        ),
      ),
    );
  }
}
