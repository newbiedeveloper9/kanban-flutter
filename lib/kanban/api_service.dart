import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models.dart';

class ApiService {
  final String apiUrl = 'https://localhost:44314';
  final Map<String, String> headers = {
    "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjEyMGYxMjhlLWFiNGItNDBlMi1iZmJhLTg5YzgxN2E5ODMwYiIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwidWlkIjoiM2Y5YmY5ZWItN2EyNS00NWVlLTkxMmItYjFlMzA0MmFjMDMwIiwiaXAiOiIxNzIuMTcuMC4yIiwicm9sZXMiOlsiQWRtaW4iLCJNb2RlcmF0b3IiLCJCYXNpYyJdLCJleHAiOjE2OTE5NTA4NzksImlzcyI6IklkZW50aXR5IiwiYXVkIjoiSWRlbnRpdHlVc2VyIn0.86G7JDjRXiJo9sktDLea4du6jC5mjHd66CNnl5CfpZk",
    "Content-Type": "application/json",
  };

  Future<Board> fetchBoard(String id) async {
    final response = await http.get(
      Uri.parse(apiUrl + '/api/board/' + id),
      headers: headers,
    );

    await Future.delayed(Duration(seconds: 2));

    if (response.statusCode == 200) {
      return Board.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load board');
    }
  }
}
