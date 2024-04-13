import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/tasks_provider.dart';
import 'package:todo_app/widgets/my_input_field.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    Key? key,
    required this.title,
    this.padding = 20.0,
    this.margin = 20.0,
    this.fontSize = 24.0,
    required this.isCompleted,
    required this.taskNo,
    required this.index,
  }) : super(key: key);

  final String? title;
  final double margin;
  final double padding;
  final double fontSize;
  final bool isCompleted;
  final int taskNo;
  final int index;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final taskProvider = Provider.of<TaskProvider>(context);
    return Container(
      width: screenWidth * 0.7,
      height: screenHeight * 0.25,
      margin: EdgeInsets.all(margin),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.purpleAccent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(),
              Text(
                'Task #${index + 1}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Icon(
                isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
                color: Colors.black,
              ),
            ],
          ),
          Text(
            title ?? '',
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Colors.black,
              fontSize: fontSize,
            ),
            maxLines: 3,
          ),
          InkWell(
            onTap: () {
              TextEditingController taskController = TextEditingController();
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 350,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Task #${(taskNo + 1).toString()}',
                            style: const TextStyle(fontSize: 24),
                          ),
                          MyInputField(
                            hintText: title ?? '',
                            icon: Icons.edit,
                            controller: taskController,
                          ),
                          Row(
                            children: [
                              const Text('Completed: '),
                              Checkbox(
                                value: isCompleted,
                                onChanged: (value) {
                                  // taskProvider.markCompleted(value!, taskNo);
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 500,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                              ),
                              child: const Text('Update Todo'),
                            ),
                          ),
                          SizedBox(
                            width: 500,
                            child: ElevatedButton(
                              onPressed: () {
                                taskProvider.deleteTask(taskNo);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purpleAccent,
                              ),
                              child: const Text('Delete Todo'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.all(
                5,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: screenWidth * 0.30,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              child: Icon(
                                Icons.launch_outlined,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'View Task',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
