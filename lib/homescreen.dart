// ignore_for_file: avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:todo_app/addtodo.dart';
import 'package:todo_app/menushape/settings_shape.dart';
import 'package:todo_app/repository/database_repository.dart';
import 'package:todo_app/todomodel.dart';
import 'package:todo_app/todowidget.dart';
import 'package:todo_app/constants/dynamic_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DynamicList dynamicList = DynamicList();
  ToDoModel emptyModal = ToDoModel(title: '', description: '', isImportant: false);
  bool callBack(ToDoModel todomodel) {
    delete(todo: todomodel, context: context);
    getTodos();
    setState(() {});
    return true;
  }
  bool updateCallBack (){
    setState(() {
      getTodos();
    });
    return true;
  }

  void initDb() async {
    await DatabaseRepository.instance.database;
  }

  void getTodos() async {
    await DatabaseRepository.instance.getAllTodos().then((value) {
      dynamicList.myTodos = value;
    // ignore: invalid_return_type_for_catch_error
    }).catchError((e) => debugPrint(e.toString()));
    setState(() {

    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    initDb();
    getTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themes = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        enableFeedback: false,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddTodoScreen(
            toDoModel: emptyModal,
            buttonName: 'Add Todo',
            updateCallBackFunction: updateCallBack,)));
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(Icons.edit_note, size: 35,
          color: themes.iconTheme.color,
          ),
        ),
        title: Text('My ToDo\'s', style: themes.textTheme.displayMedium,),
        actions: [
          PopupMenuButton(
            shape: const TooltipShape(),
            offset: const Offset(-10, 50),
            icon: Icon(Icons.more_vert_rounded, size: 25.0,
              color: themes.iconTheme.color,
            ),
            onSelected: (value){
              if(value == 1) {
                DatabaseRepository.instance.deleteAll().then((value) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('All Todo\'s deleted Successfully')));
                  setState(() {
                    getTodos();
                  });
                }).onError((error, stackTrace){
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(error.toString())));
                });
              }
            },
              itemBuilder: (BuildContext context){
              return [
                const PopupMenuItem(
                  value: 1,
                  child: Text('Delete all todo\'s'),
                ),
              ];
            }
          ),
        ],
      ),
      body:
      dynamicList.myTodos.isEmpty ?
      Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage('images/empty_box.jpg'),
          ),
          SizedBox(height: 30,),
          Text('You don\'t have any TODO\'s yet'),
        ],
      ),) :
      ListView.separated(
        scrollDirection: Axis.vertical,
        separatorBuilder: (context, index) => const SizedBox(
          height: 20,
        ),
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final todo = dynamicList.myTodos[index];
          return TodoWidget(
              todomodel: todo,
              callBackFunction: callBack,
              updateCallBack: updateCallBack,
          );
        },
        itemCount: dynamicList.myTodos.length,
      ),
    );
  }

  Future delete({required ToDoModel todo, required BuildContext context}) async {
    DatabaseRepository.instance.delete(todo.id!).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Deleted')));
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }


}

