class ToDoModel {
  final int? id;
  late final bool isImportant;
  final String title;
  final String description;
  ToDoModel(
      {required this.title,
        this.id,
        required this.description,
        required this.isImportant});

  factory ToDoModel.fromJson(Map<String, dynamic> map) {
    return ToDoModel(
      title: map['title'],
      id: map['id'],
      description: map['description'],
      isImportant: map['isImportant'] == 1,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'description': description,
      'isImportant': isImportant == true ? 1 : 0,
    };
  }
}