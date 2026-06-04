import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String title;
  final Function()? onPaymentSuccess;

  const WebViewScreen({
    super.key,
    required this.url,
    required this.title,
    this.onPaymentSuccess,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool isLoading = true;
  bool _successTriggered = false;

  void _handleSuccess() {
    if (_successTriggered) return;
    _successTriggered = true;
    if (widget.onPaymentSuccess != null) {
      widget.onPaymentSuccess!();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            // Stripe success URL detection - early detection
            if (url.contains('success') || url.contains('checkout-success')) {
              _handleSuccess();
              return;
            }
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            // Stripe success URL detection - common patterns
            if (request.url.contains('success') || request.url.contains('checkout-success')) {
              _handleSuccess();
              return NavigationDecision.prevent; // Don't even load the success page
            }
            return NavigationDecision.navigate;
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebView error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
