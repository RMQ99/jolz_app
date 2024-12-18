import '../../domain/repositories/webview_repository.dart';
import '../datasources/webview_datasource.dart';

class WebViewRepositoryImpl implements WebViewRepository {
  final WebViewDataSource dataSource;


  WebViewRepositoryImpl({required this.dataSource});

  @override
  Future<void> loadUrl() async {
    await dataSource.loadUrl();
  }

  @override
  Future<void> reload() async {
    await dataSource.reload();
  }
}