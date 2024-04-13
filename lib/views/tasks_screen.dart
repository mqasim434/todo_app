import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/tasks_model.dart';
import 'package:todo_app/providers/tasks_provider.dart';
import 'package:todo_app/repository/shared_preferences_service.dart';
import 'package:todo_app/widgets/task_widget.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaskProvider tasksProvider = Provider.of<TaskProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TODOS',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<Todos>>(
          future: SharedPreferencesServices.getTodosLocally(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final todosList = snapshot.data;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: todosList?.length ?? 0,
                itemBuilder: (context, index) {
                  final task = todosList![index];
                  return TaskWidget(
                    padding: 10,
                    margin: 10,
                    isCompleted: task.completed as bool,
                    fontSize: 20,
                    index: index,
                    title: task.todo,
                    taskNo: task.id!.toInt(),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                if (tasksProvider.currentPage >= 1) {
                  tasksProvider.previousPage();
                }
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: tasksProvider.currentPage <= 1 ? Colors.grey : Colors.white,
              ),
            ),
            const Text(
              '10',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            IconButton(
              onPressed: () {
                tasksProvider.nextPage();
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
