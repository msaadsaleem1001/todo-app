import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo_app/repository/database_repository.dart';
import 'package:todo_app/todomodel.dart';

class AddTodoScreen extends StatefulWidget {
  final String buttonName;
  final ToDoModel toDoModel;
  final Function updateCallBackFunction;
  const AddTodoScreen({
    Key? key,
    required this.toDoModel,
    required this.buttonName,
    required this.updateCallBackFunction,
  }) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  int count = 0, imp = 0;
  bool important = false, spinner = false;
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();

  void addTodo() async {
    if (widget.toDoModel.title == '' &&
        widget.toDoModel.description == '' &&
        widget.toDoModel.isImportant == false) {
      ToDoModel todo = ToDoModel(
          title: titleController.text,
          description: subtitleController.text,
          isImportant: important);
      DatabaseRepository.instance.insert(todo: todo).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Added Successfully')));
        setState(() {
          titleController.text = '';
          subtitleController.text = '';
          important = false;
          widget.updateCallBackFunction();
        });
      }).catchError((e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    } else {
      ToDoModel todoUpdate = ToDoModel(
          id: widget.toDoModel.id,
          title: titleController.text,
          description: subtitleController.text,
          isImportant: important);
      DatabaseRepository.instance.update(todoUpdate).then((value) {
        if (widget.updateCallBackFunction()) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Updated Successfully')));
          FocusScope.of(context).unfocus();
          Timer(
              const Duration(milliseconds: 1500), () => Navigator.pop(context));
        }
      }).catchError((e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    super.dispose();
  }

  void initDb() async {
    await DatabaseRepository.instance.database;
  }

  @override
  void initState() {
    initDb();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final themes = Theme.of(context);
    if (count == 0) {
      if (widget.toDoModel.title == '' && widget.toDoModel.description == '') {
        titleController.text = widget.toDoModel.title;
        subtitleController.text = widget.toDoModel.description;
        if (imp == 0) {
          if (widget.toDoModel.isImportant) {
            important = true;
          } else {
            important = false;
          }
        }
      } else {
        titleController.text = widget.toDoModel.title;
        subtitleController.text = widget.toDoModel.description;
        if (imp == 0) {
          important = widget.toDoModel.isImportant;
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.buttonName),
        actions: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                titleController.text = '';
                subtitleController.text = '';
                important = false;
              });
            },
            icon: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.cleaning_services_outlined),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
                children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
                child: spinner? const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 4.0,
                    color: Colors.greenAccent,
                  ),
                ) : const SizedBox(),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Icon(
                      Icons.edit_note_rounded,
                      size: 100,
                      color: themes.iconTheme.color,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter title';
                        } else if (value.length >= 4) {
                          return null;
                        } else {
                          return 'Please enter title at least four characters';
                        }
                      },
                      maxLength: 50,
                      keyboardType: TextInputType.text,
                      cursorColor: brightness == Brightness.dark
                          ? Colors.grey.shade500
                          : Colors.grey.shade700,
                      controller: titleController,
                      onChanged: (value) {
                        count++;
                        _formKey.currentState!.validate();
                      },
                      decoration: InputDecoration(
                        hintText: "Todo title",
                        label: const Text('Todo title *'),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: Colors.green,
                              width: 2,
                            )),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 1,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red.withOpacity(0.6),
                            width: 1,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red.withOpacity(0.6),
                            width: 1,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(10),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter description';
                        } else if (value.length >= 50) {
                          return null;
                        } else {
                          return 'Please enter description at least 50 characters';
                        }
                      },
                      maxLines: 5,
                      keyboardType: TextInputType.text,
                      maxLength: 200,
                      cursorColor: brightness == Brightness.dark
                          ? Colors.grey.shade500
                          : Colors.grey.shade700,
                      controller: subtitleController,
                      onChanged: (value) {
                        _formKey.currentState!.validate();
                        count++;
                      },
                      decoration: InputDecoration(
                        hintText: 'Todo description',
                        label: const Text('Todo description *'),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: Colors.green,
                              width: 2,
                            )),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 1,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red.withOpacity(0.6),
                            width: 1,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red.withOpacity(0.6),
                            width: 1,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(10),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SwitchListTile.adaptive(
                      activeColor: Colors.greenAccent,
                      title: Row(
                        children: [
                          const Text('Is your todo really important'),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '*',
                            style: TextStyle(
                                color: brightness == Brightness.dark
                                    ? Colors.redAccent.shade100
                                    : Colors.redAccent),
                          )
                        ],
                      ),
                      value: important,
                      enableFeedback: false,
                      onChanged: (value) => setState(
                        () {
                          imp++;
                          important = value;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    spinner? Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0)),
                      elevation: 18,
                      clipBehavior: Clip.antiAlias,
                      child: Opacity(
                        opacity: 0.4,
                        child: MaterialButton(
                          enableFeedback: false,
                          height: 50,
                          color: themes.primaryColor,
                          minWidth: double.infinity,
                          onPressed: () {},
                          child: Text(
                            widget.buttonName,
                          ),
                        ),
                      ),
                    ) : Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0)),
                      elevation: 18,
                      clipBehavior: Clip.antiAlias,
                      child: MaterialButton(
                        enableFeedback: false,
                        height: 50,
                        color: themes.primaryColor,
                        minWidth: double.infinity,
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              spinner = true;
                            });
                            Timer.periodic(const Duration(milliseconds: 1500), (t) {
                              setState(() {
                                spinner = false; //set loading to false
                                addTodo();
                              });
                              t.cancel(); //stops the timer
                            });
                          }
                        },
                        child: Text(
                          widget.buttonName,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
