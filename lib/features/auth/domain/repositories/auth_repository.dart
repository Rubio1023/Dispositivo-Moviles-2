import 'package:grove_street/features/auth/domain/entities/user_session.dart';

// esta parte solo se encarga de definir la funcion de como va el login y que datos se pide en este y devuelve el UsserSession en resumen una clase abstracta que define la funcion del login

abstract class AuthRepository {
  Future<UserSession> login({ 
    required String email,
    required String password,
  });
}