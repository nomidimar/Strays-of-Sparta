import 'package:http/http.dart' as http;

class APIService {
  static const String baseUrl = 'http://localhost:3000'; // Replace with your backend URL

  Future<String> fetchData() async {
    final response = await http.get(Uri.parse('$baseUrl/'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
