abstract class WebViewEvent {}

class LoadWebView extends WebViewEvent {
  final String url;

  LoadWebView(this.url);
}

class ReloadWebView extends WebViewEvent {
  final String url;
  ReloadWebView(this.url);

}