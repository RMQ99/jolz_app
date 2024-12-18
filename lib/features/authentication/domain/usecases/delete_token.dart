import '../repositories/token_repository.dart';

class DeleteToken {
  final TokenRepository repository;

  DeleteToken(this.repository);

  Future<void> call() async {
    await repository.deleteToken();
  }
}