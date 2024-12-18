import '../entities/token.dart';
import '../repositories/token_repository.dart';

class GetToken {
  final TokenRepository repository;

  GetToken(this.repository);

  Future<Token?> call() async {
    return await repository.getToken();
  }
}