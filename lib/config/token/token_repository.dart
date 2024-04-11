import 'package:pneumonia_detection/config/token/auth_token.dart';

abstract class TokenRepository {
  Future<AuthToken?> getAuthToken();
  Future<void> saveAuthToken(AuthToken authToken);
  Future<bool> isExpired();
}