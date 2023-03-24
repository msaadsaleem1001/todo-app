import 'package:flutter/material.dart';
import 'package:todo_app/addtodo.dart';
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
                  child: Text(
                    'No',
                    style: Theme.of(context).textTheme.displaySmall,
                  )),
              // The yes button
              TextButton(
                  onPressed: () {
                    if (callBackFunction(todoModel)) {
                      // Close the dialog
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    'Yes',
                    style: Theme.of(context).textTheme.displaySmall,
                  )),
            ],
          );
        });
  }

  void _showTodoContent(BuildContext context, ToDoModel todoModel) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: Icon(
                todoModel.isImportant
                    ? Icons.warning_amber_sharp
                    : Icons.check_box,
                size: 25,
                color: todomodel.isImportant
                    ? Colors.red.withOpacity(0.7)
                    : Colors.green.withOpacity(0.7),
            ),
            title: Text(todoModel.title),
            content: Text(todoModel.description),
            actions: [
              TextButton(
                  onPressed: () {
                      // Close the dialog
                      Navigator.of(context).pop();
                  },
                  child: Text(
                    'Ok',
                    style: Theme.of(context).textTheme.displaySmall,
                  )),
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return GestureDetector(
      onTap: (){
        if(todomodel.description.length > 52){
          _showTodoContent(context, todomodel);
        }
        else{
          // Nothing
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: todomodel.isImportant
                ? Colors.red.withOpacity(0.1)
                : Colors.grey.withOpacity(0.1)),
        child: ListTile(
          leading: IconButton(
            enableFeedback: false,
            onPressed: () => _deleteAsking(context, todomodel),
            icon: Icon(
              Icons.delete_outline_sharp,
              color: Colors.red.withOpacity(0.7),
            ),
          ),
          title: Text(
            todomodel.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
            color: brightness == Brightness.dark? Colors.white.withOpacity(0.8): Colors.grey.shade700,
            ),
          ),
          subtitle: RichText(

            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: todomodel.description,
              style: TextStyle(fontSize: 14,
                  color: brightness == Brightness.dark? Colors.white60: Colors.grey.shade700,
              ),
            ),
          ),
          trailing: IconButton(
            enableFeedback: false,
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
                size: 25,
              )),
        ),
      ),
    );
  }
}
