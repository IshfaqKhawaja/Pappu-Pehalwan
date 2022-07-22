import 'package:flutter/material.dart';

class YoganaContainer extends StatelessWidget {
  final  title;
  final description;
  final url;
  const YoganaContainer({Key? key, this.description, this.title, this.url,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
        centerTitle: true,
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
