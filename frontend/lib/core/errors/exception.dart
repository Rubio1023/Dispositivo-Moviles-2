// lib/core/errors/exceptions.dart

// Excepción base para errores del servidor (4xx, 5xx)
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  const ServerException({required this.message, this.statusCode});
  
  @override
  String toString() => 'ServerException: $message (Status: $statusCode)';
}

// Excepción para problemas de conexión/tiempo de espera
class ConnectionException implements Exception {
  final String message;
  const ConnectionException({required this.message});
}