import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class YoganaContainer extends StatelessWidget {
  final title;
  final description;
  final url;
  final type;

  const YoganaContainer({
    Key? key,
    this.description,
    this.title,
    this.url,
    this.type = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async{
                final box = context.findRenderObject() as RenderBox?;
                final urlImage = Uri.parse(url);
                final response = await http.get(urlImage);
                final bytes = response.bodyBytes;

                // Saving image bytes in local storage of your Phone

                final temp = await getTemporaryDirectory();
                final path = '${temp.path}/image.jpg';
                File(path).writeAsBytesSync(bytes);

                await Share.shareFiles(
                  [path],
                  text: 'Title: $title\n\nDescription: $description',
                  sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size
                );
              },
              icon: const Icon(Icons.share)
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Image.network(url),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Text(description),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
