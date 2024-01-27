import 'package:http/http.dart' as http;

class APIService {
  static const String baseUrl = 'http://94.68.114.8:3000/';

  Future<String> fetchData() async {
    final response = await http.get(Uri.parse('$baseUrl/'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
