import '../entities/token.dart';
import '../repositories/token_repository.dart';

class SaveToken {
  final TokenRepository repository;

  SaveToken(this.repository);

  Future<void> call(Token token) async {
    await repository.saveToken(token);
  }
}