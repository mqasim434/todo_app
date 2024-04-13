import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/navbar_provider.dart';

class MyNavBar extends StatelessWidget {
  const MyNavBar({
    super.key,
    required this.navItems,
    this.backgroundColor,
  });

  final List<NavItem> navItems;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: navItems,
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.label,
    required this.activeIcon,
    required this.inActiveIcon,
    required this.index,
    required this.onTap,
  });

  final String? label;
  final IconData? activeIcon;
  final IconData? inActiveIcon;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<BottomNavbarProvider>(context);
    bool isSelected = navProvider.selectedIndex == index;
    return InkWell(
      onTap: () {
        onTap.call();
        navProvider.changeIndex(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? activeIcon : inActiveIcon,
            color: isSelected ? Colors.white : Colors.black,
          ),
          Text(
            label.toString(),
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: isSelected ? Colors.purpleAccent : Colors.transparent,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }
}
