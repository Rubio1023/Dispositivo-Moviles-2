// tokens esta clase guarda el inicio de session de los usuarios con el acccestoken que guarda el token principal y el refreshtoken que guarda el primer toquen que se uso cuando caduca

class UserSession {
  final String accessToken;
  final String refreshToken;

  UserSession({
    required this.accessToken,
    required this.refreshToken,
  });
}