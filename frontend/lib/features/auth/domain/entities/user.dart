// lib/features/auth/domain/entities/user.dart

import 'package:equatable/equatable.dart';

// El 'User' es la representación más pura de un usuario para tu app.
// Hereda de Equatable para facilitar la comparación de objetos.
class User extends Equatable {
  final String id;
  final String name;
  final String token; // El token es parte de la sesión de negocio

  const User({
    required this.id,
    required this.name,
    required this.token,
  });

  // Equatable requiere que se definan las propiedades para la comparación
  @override
  List<Object> get props => [id, name, token];
}