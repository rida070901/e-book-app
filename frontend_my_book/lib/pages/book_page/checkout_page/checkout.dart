import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book/pages/book_page/checkout_page/bloc/checkout_blocs.dart';
import 'package:my_book/pages/book_page/checkout_page/bloc/checkout_events.dart';
import 'package:my_book/pages/book_page/checkout_page/bloc/checkout_states.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../common/values/colors.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {

  late final WebViewController webViewController;

  @override
  void initState(){
    super.initState();
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    //pass in this method and not initState() bc context does not exist yet there
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    context.read<CheckoutBloc>().add(TriggerCheckout(args["url"]));
  }

  @override
  void dispose(){
    webViewController.clearCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("my build method");
    return BlocBuilder<CheckoutBloc, CheckoutState>(builder: (context, state){
      return Scaffold(
        appBar: AppBar(title: const Text("Payment", style: TextStyle(color: AppColors.warmPink)),),

        body: state.url=="" ?
        const Center(
            child: CircularProgressIndicator(
              backgroundColor: AppColors.greyBackground,
              color: AppColors.warmPink,))
        : WebView(
          initialUrl: state.url,
          javascriptMode: JavascriptMode.unrestricted,
          javascriptChannels: {
            JavascriptChannel(
              name: "Pay",
              onMessageReceived: (JavascriptMessage message){
                print(message.message);
                Navigator.of(context).pop(message.message); //message is "success" sent from backend (success.blade.php file)
              }
            ),
          },
          onWebViewCreated: (WebViewController w){
            webViewController = w;
          },
        )
      );
    });
  }
}
