abstract class TokenEvent {}

class TokenLoad extends TokenEvent {}

class TokenSave extends TokenEvent {
  final String token;
  TokenSave(this.token);
}

class TokenDelete extends TokenEvent {}