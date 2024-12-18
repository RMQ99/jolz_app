import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/token.dart';
import '../../domain/usecases/get_token.dart';
import '../../domain/usecases/save_token.dart';
import '../../domain/usecases/delete_token.dart';
import 'token_event.dart';
import 'token_state.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  final GetToken getToken;
  final SaveToken saveToken;
  final DeleteToken deleteToken;

  TokenBloc({
    required this.getToken,
    required this.saveToken,
    required this.deleteToken,
  }) : super(TokenInitial()) {
    on<TokenLoad>((event, emit) async {
      try {
        final token = await getToken();
        if (token != null) {
          emit(TokenLoadSuccess(token.value));
        } else {
          emit(TokenLoadFailure());
        }
      } catch (_) {
        emit(TokenLoadFailure());
      }
    });

    on<TokenSave>((event, emit) async {
      try {
        await saveToken(Token(event.token));
        emit(TokenSaveSuccess());
      } catch (_) {
        emit(TokenSaveFailure());
      }
    });

    on<TokenDelete>((event, emit) async {
      try {
        await deleteToken();
        emit(TokenDeleteSuccess());
      } catch (_) {
        emit(TokenDeleteFailure());
      }
    });
  }
}