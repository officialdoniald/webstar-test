import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseApiProvider {
  final apiUrl = "https://ergast.com/api/f1/";
  final header = {"content-type": "application/json"};

  Uri getUriFromEndpointAndApiURL(String endpoint) {
    return Uri.parse(apiUrl + endpoint);
  }

  Future<String?> post(
    String path,
    Map<String, dynamic> data, {
    Map<String, String> headers = const {},
  }) async {
    if (headers.isEmpty) {
      headers = {
        "content-type": "application/json",
      };
    }

    var response = await http.post(
      getUriFromEndpointAndApiURL(path),
      headers: headers,
      body: jsonEncode(data),
    );

    print('Request url: ' + getUriFromEndpointAndApiURL(path).toString());
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  Future<String?> get(
    String path, {
    Map<String, String> headers = const {},
  }) async {
    if (headers.isEmpty) {
      headers = {
        "content-type": "application/json",
      };
    }

    var response = await http.get(
      getUriFromEndpointAndApiURL(path),
      headers: headers,
    );

    print('Request url: ' + getUriFromEndpointAndApiURL(path).toString());
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}
