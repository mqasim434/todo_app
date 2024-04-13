import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/providers/registration_provider.dart';
import 'package:todo_app/providers/tasks_provider.dart';
import 'package:todo_app/repository/shared_preferences_service.dart';
import 'package:todo_app/views/home.dart';
import 'package:todo_app/widgets/my_input_field.dart';

class SignInScreen extends StatelessWidget {

  late SharedPreferences sharedPreferences;

  void intiPrefs()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final tasksProvider = Provider.of<TaskProvider>(context);
    RegistrationProvider registrationProvider =
        Provider.of<RegistrationProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/bg.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'TODO APP',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.4,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ),
                  ),
                  child: Form(
                    child: Column(
                      children: [
                        const Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        const Spacer(),
                        MyInputField(
                          hintText: 'Username',
                          icon: Icons.person_outline,
                          controller: usernameController,
                        ),
                        const Spacer(),
                        MyInputField(
                          hintText: 'Password',
                          icon: Icons.password,
                          controller: passwordController,
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(
                              500,
                              55,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ),
                            ),
                          ),
                          onPressed: () async {
                            print('HELLO');
                            await registrationProvider
                                .signInWithEmail(
                                  'kminchelle',
                                  '0lelplR',
                                )
                                .then(
                                  (value)async {
                                   await tasksProvider.fetchTasksFromApi().then((value){
                                     SharedPreferencesServices.saveTodosLocally(tasksProvider.todosList).then((value) {
                                       SharedPreferencesServices.saveToken(UserModel.signedInUser.token.toString());
                                       Navigator.pushReplacement(
                                         context,
                                         MaterialPageRoute(
                                           builder: (context) => Home(),
                                         ),
                                       );
                                     });
                                   });
                                }
                                );
                          },
                          child: const Text(
                            'Sign in',
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 120,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
