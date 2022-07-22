import 'package:flutter/material.dart';
import 'body_part_1.dart';
import 'body_part_2.dart';
import 'body_part_2_JS.dart';
import 'body_part_3.dart';

class BodyHome extends StatefulWidget {
  final scaffoldKey;
  const BodyHome({Key? key, this.scaffoldKey,}) : super(key: key);

  @override
  State<BodyHome> createState() => _StateBodyHome();
}

class _StateBodyHome extends State<BodyHome> {
  final controller = ScrollController();
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const spaceWidget = SizedBox(
      height: 20,
    );
    return Column(
      children: [
        BodyPart2JS(
            scaffoldKey: widget.scaffoldKey,

        ),
        // spaceWidget,

        Expanded(
          child: ListView(
            children: [
              Divider(
                color: Theme.of(context).primaryColor,
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              BodyPart1(),


              Divider(
                color: Theme.of(context).primaryColor,
                thickness: 1,
              ),
              BodyPart3(),
            ],
          ),
        ),
        // spaceWidget,
      ],
    );
  }
}
