abstract class TokenState {}

class TokenInitial extends TokenState {}

class TokenLoadSuccess extends TokenState {
  final String token;
  TokenLoadSuccess(this.token);
}

class TokenLoadFailure extends TokenState {}

class TokenSaveSuccess extends TokenState {}

class TokenSaveFailure extends TokenState {}

class TokenDeleteSuccess extends TokenState {}

class TokenDeleteFailure extends TokenState {}