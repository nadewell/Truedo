import 'dart:convert';

class Todo{
  int id;
  String title;
  String description;
  DateTime startTime;
  DateTime endTime;

  Todo({
    this.id,
    this.title,
    this.description,
    this.startTime,
    this.endTime
  });

  factory Todo.fromMap(Map<String, dynamic> json ) => new Todo(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    startTime: json["start_time"],
    endTime: json["end_time"],
  );

  Map<String, dynamic> toMap() => {
    "id":id,
    "title":title,
    "description":description,
    "startTime":startTime,
    "endTime":endTime,
  };
}

Todo todoFromJson(String str){
    final jsonData = json.decode(str);
    return Todo.fromMap(jsonData);
}

String todoToJson(Todo data){
  final jsonObj = data.toMap();
  return json.encode(jsonObj);
}