import 'dart:convert';
import 'package:todo_app/model/todo.dart';
import 'package:http/http.dart' as http;

class TodoService {
  final String url = 'https://dummyjson.com/todos';
  final String addUrl = 'https://dummyjson.com/todos/add';

  Future<List<Todo>> getUncompletedTodos() async {
    final response = await http.get(Uri.parse(url));
    //print('Status code: ${response.statusCode}');
    // print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      List<dynamic> resp = jsonResponse["todos"]; // Adjust to the actual key
      List<Todo> todos = [];
      for (var element in resp) {
        Todo task = Todo.fromJson(element);
        if (task.completed == false) {
          todos.add(task);
        }
      }
      return todos;
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<List<Todo>> getCompletedTodos() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      List<dynamic> resp = jsonResponse["todos"]; // Adjust to the actual key
      List<Todo> todos = [];
      for (var element in resp) {
        Todo task = Todo.fromJson(element);
        if (task.completed == true) {
          todos.add(task);
        }
      }
      return todos;
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<String> addTodo(Todo newTodo) async {
    final response = await http.post(
      Uri.parse(addUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: json.encode(newTodo.toJson()),
    );
    print(response.body);
    return response.body;
  }
}



// import 'dart:convert';
// import 'package:todo_app/model/todo.dart';
// import 'package:http/http.dart' as http;

// class TodoService{
  
//   final String url= 'https://dummyjson.com/todos';

//   Future<List<Todo>> getUncomplatedTodos() async{
//     final response =  await http.get(Uri.parse(url));

//     List<dynamic> resp = jsonDecode(response.body); //it is json format
//     List<Todo> todos = List.empty(growable: true); 
//     for (var element in resp) {
//       Todo task = Todo.fromJson(element);
//       if(task.completed! == false){
//         todos.add(task);
//       }
//     }
//     return todos;
    
//   }
//  Future<List<Todo>> getComplatedTodos() async{
//     final response =  await http.get(Uri.parse(url));
//     List<dynamic> resp = jsonDecode(response.body); //it is json format
//     List<Todo> todos = List.empty(growable: true); 
//     for (var element in resp) {
//       Todo task = Todo.fromJson(element);
//       if(task.completed! == true){
//         todos.add(task);
//       }
//     }
//     return todos;
//   }
// }