import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ERPSite extends StatefulWidget {
  const ERPSite({super.key});

  @override
  State<ERPSite> createState() => _ERPSiteState();
}

class _ERPSiteState extends State<ERPSite> {
  final controller = WebViewController();
  bool _canGoBack = false;
  loadStore() {
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.blueGrey)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) async {
            bool canGoBackNow = await controller.canGoBack();
            if (canGoBackNow != _canGoBack) {
              setState(() {
                _canGoBack = canGoBackNow;
              });
            }
          },
          // onHttpError: (HttpResponseError error) {
          //   debugPrint('Error occurred on page: ${error.response?.statusCode}');
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text('HTTP Error: ${error.response?.statusCode}'),
          //       backgroundColor: Colors.red,
          //     ),
          //   );
          // },
        ),
      )
      ..loadRequest(Uri.parse('https://erp.shakti.org.bd/'));
  }

  @override
  void initState() {
    loadStore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shakti AppView'),centerTitle: true,),
      body: WebViewWidget(controller: controller),
      floatingActionButton:
      _canGoBack
          ? FloatingActionButton(
        onPressed: () async {
          if (await controller.canGoBack()) {
            controller.goBack();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('No more back history')),
            );
          }
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Colors.blue,
      )
          : null,
      // floatingActionButton: FloatingActionButton(onPressed: ()async{
      //   if(await controller.canGoBack()){
      //     return controller.goBack();
      //   }else{
      //     //return null;
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(content: Text('No more back history')),
      //     );
      //   }
      // },
      //   child: Icon(Icons.arrow_back),
      //   backgroundColor: Colors.cyan,
      // ),
    );
  }
}