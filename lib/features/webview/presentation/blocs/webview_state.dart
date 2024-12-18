abstract class WebViewState {}

class WebViewInitial extends WebViewState {}

class WebViewLoading extends WebViewState {}

class WebViewLoaded extends WebViewState {}

class WebViewError extends WebViewState {
  final String message;

  WebViewError(this.message);
}