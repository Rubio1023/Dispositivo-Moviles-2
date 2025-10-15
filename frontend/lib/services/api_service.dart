import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api'; // cambiar si usas físico

  // register
  static Future<Map<String, dynamic>> registerUser(String name, String username, String password) async {
    final url = Uri.parse('$baseUrl/register/');
    final resp = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'username': username, 'password': password}));
    return _parse(resp);
  }

  // login
  static Future<Map<String, dynamic>> loginUser(String username, String password) async {
    final url = Uri.parse('$baseUrl/login/');
    final resp = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}));
    return _parse(resp);
  }

  // products
  static Future<List<dynamic>> getProducts() async {
    final url = Uri.parse('$baseUrl/products/');
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      return jsonDecode(resp.body) as List<dynamic>;
    } else {
      throw Exception('Error cargando productos');
    }
  }

  // pay: enviar username y cart [{id,quantity}]
  static Future<Map<String, dynamic>> payCart(String username, List<Map<String, dynamic>> cart) async {
    final url = Uri.parse('$baseUrl/pay/');
    final resp = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'cart': cart}));
    return _parse(resp);
  }

  static Map<String, dynamic> _parse(http.Response resp) {
    try {
      final data = jsonDecode(resp.body);
      return {'status': resp.statusCode, 'data': data};
    } catch (e) {
      return {'status': resp.statusCode, 'data': resp.body};
    }
  }
}
