import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models.dart';

class ApiService {
  final String apiUrl = 'http://192.168.0.100:5000';
  final Map<String, String> headers = {
    "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6ImM3Y2U1MDdkLWQzOTMtNDVmMC04YTBkLTk3MzM5OGI2OWMzMiIsImVtYWlsIjoiYWRtaW5AZ21haWwuY29tIiwidWlkIjoiM2Y5YmY5ZWItN2EyNS00NWVlLTkxMmItYjFlMzA0MmFjMDMwIiwiaXAiOiIyNi4yNS4xNzEuMTgyIiwicm9sZXMiOlsiQWRtaW4iLCJNb2RlcmF0b3IiLCJCYXNpYyJdLCJleHAiOjE2OTIwMjg1MjksImlzcyI6IklkZW50aXR5IiwiYXVkIjoiSWRlbnRpdHlVc2VyIn0.ZEWzK8zUEbh1ZnSI_Tp0cc2Sh4awl8chw_2YpLAQLFM",
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
