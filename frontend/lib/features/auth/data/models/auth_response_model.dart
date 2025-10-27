// lib/features/auth/data/models/auth_response_model.dart

import '../../../domain/entities/user.dart'; // Importa la Entidad Pura del Dominio

class AuthResponseModel {
  final String token;
  final String userId;
  final String username;
  // Otros campos de la respuesta de la API...

  AuthResponseModel({
    required this.token,
    required this.userId,
    required this.username,
  });

  // Constructor de fábrica para crear el Modelo a partir del JSON de la API
  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    // Aquí es donde parseas exactamente el JSON de tu servidor
    return AuthResponseModel(
      token: json['token'] as String,
      userId: json['user_id'] as String, // Ajusta los nombres de las claves (keys)
      username: json['username'] as String,
    );
  }

  // MÉTODO CLAVE: Convierte el Modelo de Data a la Entidad de Dominio
  User toEntity() {
    return User(
      id: userId,
      name: username, // Podrías usar otro campo si tu API lo provee
      token: token,
      // Nota: El Domain Entity (User) es la clase pura que se usa en el resto de la app.
    );
  }
}