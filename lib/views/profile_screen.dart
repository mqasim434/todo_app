import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/repository/shared_preferences_service.dart';
import 'package:todo_app/views/signin_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.purpleAccent,
        body: Center(
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.purpleAccent,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.purpleAccent,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(100),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(100),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              UserModel.signedInUser.image.toString()),
                          radius: 80,
                        ),
                        const SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListTile(
                            title: const Text('Username '),
                            trailing: Text(
                              UserModel.signedInUser.username.toString(),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListTile(
                            title: const Text('Full Name: '),
                            trailing: Text(
                              UserModel.signedInUser.firstName.toString(),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListTile(
                            title: const Text('Email: '),
                            trailing: Text(
                              UserModel.signedInUser.email.toString(),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListTile(
                            title: const Text('Gender: '),
                            trailing: Text(
                              UserModel.signedInUser.gender.toString(),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Divider(),
                        ),
                        Container(
                            width: 300,
                            margin: const EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purpleAccent,
                              ),
                              onPressed:() async{
                                SharedPreferencesServices.clearPreferences();
                                UserModel.signedInUser = UserModel();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignInScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Logout',
                                style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
                              ),
                            ),),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
