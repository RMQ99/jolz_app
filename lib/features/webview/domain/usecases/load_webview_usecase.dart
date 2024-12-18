import '../repositories/webview_repository.dart';

class LoadWebViewUseCase {
  final WebViewRepository repository;

  LoadWebViewUseCase( this.repository);

  Future<void> loadurl(String initialUrl) async {
    await repository.loadUrl();
  }
}

class ReloadWebViewUseCase {
  final WebViewRepository repository;

  ReloadWebViewUseCase( this.repository);

  Future<void> reload(String initialUrl) async {
    await repository.reload();
  }
}