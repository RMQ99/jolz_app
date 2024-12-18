import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/load_webview_usecase.dart';
import 'webview_event.dart';
import 'webview_state.dart';

class WebViewBloc extends Bloc<WebViewEvent, WebViewState> {
  final LoadWebViewUseCase loadWebViewUseCase;
  final ReloadWebViewUseCase reloadWebViewUseCase;

  WebViewBloc({
    required this.loadWebViewUseCase,
     required this.reloadWebViewUseCase})
      : super(WebViewInitial()) {
    on<LoadWebView>((event, emit) async {
      emit(WebViewLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      await loadWebViewUseCase.loadurl(event.url);
      emit(WebViewLoaded());
    });

    on<ReloadWebView>((event, emit) async {
      emit(WebViewLoading());
      await reloadWebViewUseCase.reload(event.url);
      await Future.delayed(const Duration(milliseconds: 500));
      emit(WebViewLoaded());
    });
  }
}