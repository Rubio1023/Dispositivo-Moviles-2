import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/session_manager.dart';
import '../models/product.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.9:8000/api';
  //192.168.1.9
  // Productos
  static Future<List<dynamic>> getProducts({String? query}) async {
    try {
      final url = Uri.parse(
        (query == null || query.isEmpty)
            ? '$baseUrl/products/'
            : '$baseUrl/search/?q=$query',
      );

      debugPrint('🌐 URL consultada: $url');

      final resp = await http.get(url);
      debugPrint('📡 Código de estado: ${resp.statusCode}');
      debugPrint('📦 Respuesta: ${resp.body}');

      if (resp.statusCode == 200) {
        return jsonDecode(resp.body) as List<dynamic>;
      } else {
        throw Exception('Error cargando productos (${resp.statusCode})');
      }
    } catch (e) {
      debugPrint('🔥 Error en getProducts: $e');
      rethrow;
    }
  }
  


  // Autenticación
  static Future<Map<String, dynamic>> registerUser(
      String name, String email, String password) async {
        
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await SessionManager.saveUser(data['user']);
        return {'status': 200, 'data': data};
      } else {
        return {
          'status': response.statusCode,
          'message': jsonDecode(response.body)['detail'] ?? 'Error desconocido'
        };
      }
    } catch (e) {
      return {'status': 500, 'message': e.toString()};
    }
  }

  static Future<Map<String, dynamic>> loginUser(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await SessionManager.saveUser(data['user']);
        return {'status': 200, 'data': data};
      } else {
        return {
          'status': response.statusCode,
          'message': jsonDecode(response.body)['detail'] ?? 'Error en login'
        };
      }
    } catch (e) {
      return {'status': 500, 'message': e.toString()};
    }
  }

  // Carrito 
  static Future<Map<String, dynamic>> getCart(int userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/cart/$userId/'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('No se pudo obtener el carrito');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<Map<String, dynamic>> addToCart(
      int userId, int productId, int quantity) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/add-to-cart/'), 
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': userId,
          'product': productId,
          'quantity': quantity,
        }),
      );

      // Intentar decodificar respuesta del backend
      final parsed = (response.body.isNotEmpty) ? jsonDecode(response.body) : null;

      
      return {'status': response.statusCode, 'error': parsed ?? 'Error desconocido'};
    } catch (e) {
      return {'status': 500, 'error': e.toString()};
    }
  }

  static Future<Map<String, dynamic>> updateCartItem(
      int itemId, int quantity) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/update-cart-item/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'item_id': itemId, 'quantity': quantity}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'error': jsonDecode(response.body)['error'] ??
              'Error al actualizar el carrito'
        };
      }
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  static Future<Map<String, dynamic>> removeCartItem(int itemId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/remove-cart-item/$itemId/'),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'error': 'No se pudo eliminar el item'};
      }
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  // Pago
static Future<Map<String, dynamic>> checkout(int productId, int quantity) async {
  final url = Uri.parse('$baseUrl/checkout/'); 
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'product_id': productId,
      'quantity': quantity,
    }),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    print('Checkout failed: ${response.body}');
    return {'error': 'Error procesando el pago'};
  }
}


// Busqueda
 static Future<List<Product>> searchProducts(String query) async {
    final url = Uri.parse('$baseUrl/search/?q=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Error buscando productos');
    }
  }


}
