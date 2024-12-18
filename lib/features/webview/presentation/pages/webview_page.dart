import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolz_app/features/webview/presentation/pages/splash_screen.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../core/utils/constants/constants.dart';
import '../../../authentication/domain/usecases/delete_token.dart';
import '../../../authentication/domain/usecases/get_token.dart';
import '../../../authentication/domain/usecases/save_token.dart';
import '../../../authentication/presentation/bloc/token_bloc.dart';
import '../../data/datasources/webview_datasource.dart';
import '../../data/repositories/webview_repository_impl.dart';
import '../../domain/usecases/load_webview_usecase.dart';
import '../blocs/webview_bloc.dart';
import '../blocs/webview_event.dart';
import '../blocs/webview_state.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}


class _WebViewPageState extends State<WebViewPage> {
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    _controller.reload();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    _refreshController.loadComplete();
  }

  late WebViewController _controller = WebViewController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WebViewBloc>(
          create: (_) => WebViewBloc(
           loadWebViewUseCase: LoadWebViewUseCase(WebViewRepositoryImpl(dataSource: WebViewDataSource(_controller)),),
          reloadWebViewUseCase: ReloadWebViewUseCase(WebViewRepositoryImpl(dataSource: WebViewDataSource(_controller),),),
          )
    ..add(LoadWebView(Constants.initialUrl))
        ),
        BlocProvider<TokenBloc>(
          create: (_) => TokenBloc(
            getToken: context.read<GetToken>(),
            saveToken: context.read<SaveToken>(),
            deleteToken: context.read<DeleteToken>(),
          ),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<WebViewBloc, WebViewState>(
            builder: (context, state) {
              if (state is WebViewLoading) {
                return Stack(
                  children: [
                    const Center(
                      child:
                      CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        color: Colors.black,
                      ),
                    ),
                    WebViewWidget(controller: _initializeController(),),
                  ],
                );
              } else if (state is WebViewLoaded) {
                return WebViewWidget(controller: _initializeController(),);

              } else {
                return const Center(child: Text("Error loading page"));
              }
            },
          ),
        ),
      ),
    );
  }
  WebViewController _initializeController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: _injectJavaScript,
        ),
      )
      ..loadRequest(Uri.parse(Constants.initialUrl));
    return _controller;
  }

  void _injectJavaScript(String url) {
    _controller.runJavaScript(
        "document.querySelectorAll('.subscription-wrapper.pt-20.pb-15').forEach(function(el) { el.style.display = 'none'; });"
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
  }

}


