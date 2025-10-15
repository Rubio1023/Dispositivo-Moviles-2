import 'package:grove_street/features/auth/domain/entities/user_session.dart'; 
import 'package:grove_street/features/auth/domain/repositories/auth_repository.dart';

// Esta clase se encarga de manejar el caso de uso del login, interactuando con el repositorio de autenticación para obtener la sesión del usuario.

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  // El tipo de retorno ahora es UserSession
  Future<UserSession> call({
    required String email,
    required String password,
  }) async {
    return await repository.login(email: email, password: password);
  }
}