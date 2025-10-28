// lib/core/network/api_client.dart (Hemos renombrado a ApiClient para enfatizar su rol)

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../errors/exception.dart';
import '../constants/api_constants.dart';
//import '../errors/exceptions.dart'; // Asegúrate de tener tu clase ServerException aquí

class ApiClient {
  final http.Client client;

  ApiClient({required this.client});

  // Método POST genérico
  Future<Map<String, dynamic>> post(String path, Map<String, dynamic> body) async {
    final url = Uri.parse('${ApiConstants.baseUrl}$path');
    final resp = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return _parseResponse(resp);
  }

  // Método GET genérico
  Future<dynamic> get(String path) async {
    final url = Uri.parse('${ApiConstants.baseUrl}$path');
    final resp = await client.get(url);
    
    // Para GET no usamos _parseResponse porque el cuerpo puede ser List (ej. productos)
    if (resp.statusCode == 200) {
      return jsonDecode(resp.body); 
    } else {
      throw ServerException(message: 'Error en la petición GET: ${resp.statusCode}');
    }
  }

  // Función de parseo genérica (similar a tu _parse)
  Map<String, dynamic> _parseResponse(http.Response resp) {
    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      // Éxito: intenta decodificar y devuelve el mapa.
      try {
        final data = jsonDecode(resp.body);
        return {'status': resp.statusCode, 'data': data};
      } catch (e) {
        // Devuelve el cuerpo crudo si no es JSON válido
        return {'status': resp.statusCode, 'data': resp.body}; 
      }
    } else {
      // Error: lanza una excepción customizada que la capa DATA capturará.
      throw ServerException(
          message: 'Error de Servidor: ${resp.statusCode}',
          statusCode: resp.statusCode
      );
    }
  }
}