// lib/core/errors/failures.dart

import 'package:equatable/equatable.dart';

// 1. Clase Abstracta Base
abstract class Failure extends Equatable {
  // Mantiene 'const' porque el argumento por defecto es constante
  const Failure([this.properties = const []]); 

  // Cambiado a List<Object?> para aceptar el 'message' que puede ser nulo
  final List<Object?> properties; 

  @override
  // Se usa List<Object?> para evitar errores con campos anulables (String? message)
  List<Object?> get props => properties; 
}

// 2. Fallas Específicas del Dominio (Errores del Servidor/API)
class ServerFailure extends Failure {
  final String? message;
  // 🔑 CORREGIDO: SE ELIMINA 'const' para aceptar el valor dinámico 'message'.
  ServerFailure({this.message}) : super([message]); 
}

// 3. Fallas de Caché/Almacenamiento Local
class CacheFailure extends Failure {
  final String? message;
  // 🔑 CORREGIDO: SE ELIMINA 'const' para aceptar el valor dinámico 'message'.
  CacheFailure({this.message}) : super([message]); 
}

// 4. Fallas de Conexión o Red (Puede mantener 'const' al no tener campos variables)
class ConnectionFailure extends Failure {
  const ConnectionFailure() : super(const[]);
}

// 5. Fallas de Mapeo/Serialización de Datos (Puede mantener 'const')
class DataParsingFailure extends Failure {
  const DataParsingFailure() : super(const []);
}