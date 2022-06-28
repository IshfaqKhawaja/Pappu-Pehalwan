import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWeb extends StatefulWidget {
  final title;
  final url;
  const NewsWeb({Key? key, this.url, this.title}) : super(key: key);

  @override
  State<NewsWeb> createState() => _NewsWebState();
}

class _NewsWebState extends State<NewsWeb> {
  WebViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text(
          'In the NEWS',
          overflow: TextOverflow.ellipsis, 
          style: const TextStyle(color: Colors.white)),
        
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        zoomEnabled: true,
      ),
    );
  }
}
