import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String baseUrl = "http://10.0.2.2:5000/tasks";

  // GET tasks
  static Future<List<dynamic>?> getTasks() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/getTask"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

       
        for (var task in data) {
          print("Titre: ${task["title"]}, Completed: ${task["completed"]}");
        }

        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("Erreur GET tasks: $e");
      return null;
    }
  }

  // POST addTask
  static Future<Map<String, dynamic>?> addTask(
    String title,
    String description,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/addTask"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "title": title,
          "description": description,
          "completed": false,
        }),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Erreur POST addTask: $e");
      return null;
    }
  }

  // PUT updateTask
  static Future<Map<String, dynamic>?> updateTask(String taskId) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/updateTaskStatus/$taskId"),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Erreur PUT updateTask: $e");
      return null;
    }
  }

  // DELETE deleteTask
  static Future<Map<String, dynamic>?> deleteTask(String taskId) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/deleteTask/$taskId"),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Erreur DELETE deleteTask: $e");
      return null;
    }
  }
}
