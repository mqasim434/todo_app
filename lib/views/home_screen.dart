import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:todo_app/models/tasks_model.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/providers/navbar_provider.dart';
import 'package:todo_app/repository/shared_preferences_service.dart';
import 'package:todo_app/views/signin_screen.dart';
import 'package:todo_app/widgets/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<Todos>>(
          future: SharedPreferencesServices.getTodosLocally(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final todosList = snapshot.data;
              int completedCount = 0;
              for(int i=0;i<todosList!.length;i++){
                if(todosList[i].completed==true){
                  completedCount++;
                }
              }
              double percentage = (completedCount / todosList.length) * 100;
              final ValueNotifier<double> progressNotifier = ValueNotifier<double>(percentage);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.purpleAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.network(
                                UserModel.signedInUser.image.toString()),
                          ),
                        ),
                        InkWell(
                          onTap: () async{
                            SharedPreferencesServices.clearPreferences();
                            UserModel.signedInUser = UserModel();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              ),
                            );
                          },
                          child: const CircleAvatar(
                            radius: 40,
                            child: Icon(Icons.logout),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Hello!',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 32,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      '${UserModel.signedInUser.firstName} ${UserModel.signedInUser.lastName}',
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.w500, height: 1),
                    ),
                  ),
                  Container(
                    width: screenWidth,
                    height: screenHeight * 0.2,
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.purpleAccent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Tasks Progress',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                              ),
                            ),
                            InkWell(
                              onTap: (){

                              },
                              child: Container(
                                width: 140,
                                height: 50,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  border: const Border(
                                    top: BorderSide(color: Colors.black),
                                    bottom: BorderSide(color: Colors.black),
                                    left: BorderSide(color: Colors.black),
                                    right: BorderSide(color: Colors.black),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      child: Icon(
                                        Icons.launch_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'View Task',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SimpleCircularProgressBar(
                          valueNotifier: progressNotifier,
                          progressColors: const [Colors.deepPurple],
                          
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'In Progress',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  todosList!.isEmpty
                      ? Expanded(
                    child: Center(
                      child: Container(),
                    ),
                  )
                      : Expanded(
                    child: ListView.builder(
                      itemCount: todosList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        Todos todo = todosList[index];
                        return TaskWidget(
                          title: todo.todo.toString(),
                          index: index,
                          isCompleted: todo.completed as bool,
                          taskNo: todo.id!.toInt(),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}




class CircularProgressBar extends StatelessWidget {
  final double progressPercentage;

  CircularProgressBar({required this.progressPercentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.blue,
          width: 10, // Initial border width
        ),
      ),
      child: Center(
        child: Text(
          '${progressPercentage.round()}%',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}