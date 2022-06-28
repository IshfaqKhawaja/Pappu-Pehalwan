import 'package:flutter/material.dart';
import 'body_part_3.dart';

class TagStory extends StatelessWidget {
  final title;
  const TagStory({Key? key, this.title,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        child: BodyPart3(),
      ),
    );
  }
}
