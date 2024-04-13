import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/navbar_provider.dart';
import 'package:todo_app/providers/registration_provider.dart';
import 'package:todo_app/providers/tasks_provider.dart';
import 'package:todo_app/views/home.dart';
import 'package:todo_app/views/signin_screen.dart';
import 'package:todo_app/views/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RegistrationProvider(),
        ),ChangeNotifierProvider(
          create: (_) => BottomNavbarProvider(),
        ),ChangeNotifierProvider(
          create: (_) => TaskProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Todo App',
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        theme: ThemeData.dark(),
        home: SplashScreen(),
      ),
    );
  }
}
