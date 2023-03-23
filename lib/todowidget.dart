import 'package:flutter/material.dart';
import 'package:todo_app/addtodo.dart';
import 'package:todo_app/app_theme/theme_data.dart';
import 'package:todo_app/todomodel.dart';

class TodoWidget extends StatelessWidget {
  final ToDoModel todomodel;
  final Function callBackFunction;
  final Function updateCallBack;
  const TodoWidget({
    Key? key,
    required this.todomodel,
    required this.callBackFunction,
    required this.updateCallBack,
  }) : super(key: key);

  void _deleteAsking(BuildContext context, ToDoModel todoModel) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Please Confirm!'),
            content: const Text('Are you sure to delete this ToDo?'),
            actions: [
              // The "No" button
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text('No', style: Theme.of(context).textTheme.displaySmall,)),
              // The yes button
              TextButton(
                  onPressed: () {
                    if (callBackFunction(todoModel)) {
                      // Close the dialog
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Yes',style: Theme.of(context).textTheme.displaySmall,)),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 105, right: 20),
            child: todomodel.isImportant? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.warning_amber_sharp, size: 16,
                    color: Colors.red.withOpacity(0.7)
                ),
                Text('Important', style: TextStyle(color: Colors.red.withOpacity(0.7)),)
              ],
            ):
                const SizedBox(),
          ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: todomodel.isImportant? Colors.red.withOpacity(0.1) :Colors.grey.withOpacity(0.1)),
        child: ListTile(
          title: Text(
            todomodel.title,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            todomodel.description,
            style: const TextStyle(fontSize: 14),
          ),
          trailing: const SizedBox(),
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddTodoScreen(
                              toDoModel: todomodel,
                              buttonName: 'Update Todo',
                              updateCallBackFunction: updateCallBack,
                            )));
              },
              icon: Icon(
                Icons.edit_calendar,
                color: Colors.green.withOpacity(0.7),
              )),
          IconButton(
            enableFeedback: false,
            onPressed: () => _deleteAsking(context, todomodel),
            icon: Icon(
              Icons.delete_outline_sharp,
              color: Colors.red.withOpacity(0.7),
            ),
          ),
        ],
      )
    ]);
  }
}
// IconButton(
// enableFeedback: false,
// onPressed: () => _deleteAsking(context, todomodel),
// // callBackFunction(todomodel),
// icon: Icon(
// Icons.delete_outline_sharp,
// color: Colors.red.withOpacity(0.7),
// ),
// ),
// ],
// ),
// ],
// )
