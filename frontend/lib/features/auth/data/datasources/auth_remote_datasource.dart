// lib/features/auth/data/datasources/auth_remote_datasource.dart

import '../../../../core/network/api_client.dart'; 
import '../models/auth_response_model.dart'; // El modelo que viene de la API

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> register(String name, String username, String password);
  Future<AuthResponseModel> login(String username, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient client; // El ApiClient se inyecta aquí (Inyección de Dependencias)

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthResponseModel> register(String name, String username, String password) async {
    const path = '/register/';
    final body = {'name': name, 'username': username, 'password': password};

    final respMap = await client.post(path, body);

    // *PASO CLAVE:* Mapeo del JSON de respuesta al AuthResponseModel
    return AuthResponseModel.fromJson(respMap['data']);
  }

  @override
  Future<AuthResponseModel> login(String username, String password) async {
    const path = '/login/';
    final body = {'username': username, 'password': password};

    final respMap = await client.post(path, body);
    
    // *PASO CLAVE:* Mapeo del JSON de respuesta al AuthResponseModel
    return AuthResponseModel.fromJson(respMap['data']);
  }
}