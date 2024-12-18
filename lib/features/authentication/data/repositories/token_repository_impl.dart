import '../../domain/entities/token.dart';
import '../../domain/repositories/token_repository.dart';
import '../datasources/token_local_data_source.dart';

class TokenRepositoryImpl implements TokenRepository {
  final TokenLocalDataSource localDataSource;

  TokenRepositoryImpl({required this.localDataSource});

  @override
  Future<Token?> getToken() async {
    final tokenString = await localDataSource.getToken();
    if (tokenString != null) {
      return Token(tokenString);
    }
    return null;
  }

  @override
  Future<void> saveToken(Token token) async {
    await localDataSource.saveToken(token.value);
  }

  @override
  Future<void> deleteToken() async {
    await localDataSource.deleteToken();
  }
}