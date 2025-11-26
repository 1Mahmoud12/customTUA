import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tua/core/component/custom_app_bar.dart';
import 'package:tua/core/component/loadsErros/loading_widget.dart';
import 'package:tua/core/utils/custom_show_toast.dart';
import 'package:tua/core/utils/navigate.dart';
import 'package:tua/feature/cart/data/models/hyper_pay_checkout_response.dart';
import 'package:tua/feature/cart/data/models/hyper_pay_config_response.dart';
import 'package:tua/feature/cart/view/managers/hyper_pay/hyper_pay_checkout_cubit.dart';
import 'package:tua/feature/navigation/view/presentation/navigation_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HyperPayWebView extends StatefulWidget {
  final HyperPayCheckoutInner checkoutData;
  final HyperPayConfigData config;

  const HyperPayWebView({super.key, required this.checkoutData, required this.config});

  @override
  State<HyperPayWebView> createState() => _HyperPayWebViewState();
}

class _HyperPayWebViewState extends State<HyperPayWebView> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    log('Initializing HyperPay WebView');
    log('Checkout ID: ${widget.checkoutData.id}');

    // Ensure base URL ends with /
    String baseUrl = widget.config.hyperPayPaymentUrl;
    if (!baseUrl.endsWith('/')) {
      baseUrl += '/';
    }

    // Construct HyperPay payment widget URL
    final widgetUrl = '$baseUrl/paymentWidgets.js?checkoutId=${widget.checkoutData.id}';

    log('Payment Widget URL: $widgetUrl');

    // Create HTML with HyperPay payment widget
    final htmlContent = '''
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <script src="$widgetUrl"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body { 
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .paymentWidgets {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            max-width: 500px;
            margin: 0 auto;
        }
        .wpwl-form {
            margin: 0 !important;
        }
    </style>
</head>
<body>
    <!-- HyperPay payment form will be injected here -->
    <form action="${widget.config.shopperResultUrl}" 
          class="paymentWidgets" 
          data-brands="VISA MASTER MADA AMEX">
    </form>
    
    <script>
        // Log when widget loads
        console.log('HyperPay widget script loaded');
        
        // Optional: Handle form submission
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Page loaded, waiting for payment widget...');
        });
    </script>
</body>
</html>
''';

    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (String url) {
                log('Page started loading: $url');
                if (!_isLoading) {
                  setState(() => _isLoading = true);
                }
              },
              onPageFinished: (String url) {
                log('Page finished loading: $url');
                if (_isLoading) {
                  setState(() => _isLoading = false);
                }
              },
              onUrlChange: (UrlChange change) {
                if (change.url != null && change.url!.isNotEmpty) {
                  log('URL changed: ${change.url}');
                  _handlePaymentResult(change.url!);
                }
              },
              onWebResourceError: (WebResourceError error) {
                log('WebView error: ${error.description} (Code: ${error.errorCode})');

                // Don't show error for minor resource issues
                if (error.errorType != WebResourceErrorType.unknown) {
                  customShowToast(context, 'payment_error'.tr(), showToastStatus: ShowToastStatus.error);
                }
              },
              onNavigationRequest: (NavigationRequest request) {
                log('Navigation request: ${request.url}');
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadHtmlString(htmlContent);
  }

  Future<void> _handlePaymentResult(String url) async {
    log('Handling payment result URL: $url');

    // Parse the URL
    final uri = Uri.tryParse(url);
    if (uri == null) {
      log('Could not parse URL');
      return;
    }

    // Check if this is the shopper result URL (redirect after payment)
    // HyperPay redirects to your shopperResultUrl with query parameters:
    // - id: the checkout ID
    // - resourcePath: path to query payment status

    final shopperResultUrl = widget.config.shopperResultUrl;
    if (shopperResultUrl.isEmpty) {
      log('Shopper result URL not configured');
      return;
    }

    // Parse the shopper result URL to compare
    final resultUri = Uri.tryParse(shopperResultUrl);
    if (resultUri == null) {
      log('Could not parse shopper result URL: $shopperResultUrl');
      return;
    }

    // Check if current URL matches the shopper result URL
    // Compare by host and path (ignore query parameters for matching)
    final currentHost = uri.host.toLowerCase();
    final currentPath = uri.path.toLowerCase();
    final resultHost = resultUri.host.toLowerCase();
    final resultPath = resultUri.path.toLowerCase();

    final isShopperResultUrl = currentHost == resultHost && (currentPath == resultPath || currentPath.startsWith(resultPath));

    if (isShopperResultUrl) {
      log('✅ Shopper result URL detected!');
      log('Query parameters: ${uri.queryParameters}');

      // Extract checkout ID from URL or use the one we have
      final checkoutId = uri.queryParameters['id'] ?? widget.checkoutData.id;

      log('Verifying payment with checkout ID: $checkoutId');

      // Get cubit reference before navigating (context will be invalid after pop)
      final cubit = context.read<HyperPayCubit>();

      // Call backend to verify payment status (cart/hyperpay-handler)
      // Use the cubit reference we got before popping
      log('Calling cart/hyperpay-handler with checkout ID: $checkoutId');
      await cubit.hyperPayHandler(context, checkoutId);
      // Close WebView immediately and navigate back to app
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HyperPayCubit, HyperPayState>(
      listener: (context, state) {
        if (state is HyperPaySuccess) {
          // Payment verified successfully
          log('Payment verification successful');

          Navigator.of(context).pop(); // Close WebView
          Navigator.of(context).pop(); // Close cart view
          context.navigateToPageWithReplacement(const NavigationView());

          //customShowToast(context, 'payment_successful'.tr(), showToastStatus: ShowToastStatus.success);
        } else if (state is HyperPayCheckoutError) {
          log('Payment verification failed: ${state.message}');

          Navigator.of(context).pop(); // Close WebView

          customShowToast(context, state.message, showToastStatus: ShowToastStatus.error);
        }
      },
      child: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            log('User cancelled payment');
          }
        },
        child: Scaffold(
          appBar: customAppBar(context: context, title: 'complete_payment'.tr()),
          body: Stack(
            children: [
              WebViewWidget(controller: _controller),
              if (_isLoading) Container(color: Colors.white, child: const Center(child: LoadingWidget())),
            ],
          ),
        ),
      ),
    );
  }
}
