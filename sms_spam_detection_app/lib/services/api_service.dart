import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://192.168.100.143:8000';

  Future<Map<String, dynamic>> checkSpam(String message) async {
    final uri = Uri.parse('$_baseUrl/predict');

    try {
      final response = await http
          .post(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({'message': message}),
          )
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () => throw Exception(
              'Request timed out. Please check your connection and try again.',
            ),
          );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded is! Map<String, dynamic>) {
          throw Exception('Unexpected response format from server.');
        }
        return decoded;
      } else if (response.statusCode == 422) {
        throw Exception('Invalid input. Please check your message and retry.');
      } else if (response.statusCode >= 500) {
        throw Exception(
          'Server error (${response.statusCode}). Try again later.',
        );
      } else {
        throw Exception(
          'Unexpected status ${response.statusCode}: ${response.reasonPhrase}',
        );
      }
    } on FormatException {
      throw Exception('Failed to parse server response. Invalid JSON.');
    } on http.ClientException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }
}
