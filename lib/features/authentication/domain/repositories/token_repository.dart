import '../entities/token.dart';

abstract class TokenRepository {
  Future<Token?> getToken();
  Future<void> saveToken(Token token);
  Future<void> deleteToken();
}