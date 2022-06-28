import 'package:flutter/material.dart';

class AutoFieldEditOption extends StatefulWidget {
  final addOptions;
  final lastOptionId;
  final questionIndex;
  const AutoFieldEditOption({
    Key? key,
    this.addOptions,
    this.lastOptionId,
    this.questionIndex,
  }) : super(key: key);

  @override
  State<AutoFieldEditOption> createState() => _AutoFieldEditOptionState();
}

class _AutoFieldEditOptionState extends State<AutoFieldEditOption> {
  String option = '';
  List options = [];
  int lastOptionId = -1;

  final _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    lastOptionId = widget.lastOptionId;
    options = [];
    option = '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          hintText: 'Enter Option',
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter option';
          }
          return null;
        },
        onChanged: (value) {
          setState(() {
            option = value;
          });
        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              if (option.isNotEmpty) {
                ++lastOptionId;
                widget.addOptions(
                  option,
                  lastOptionId.toString(),
                );
                setState(() {
                  options.add({
                    'title': option,
                    'id': '$lastOptionId',
                  });
                  option = '';
                  _controller.text = '';
                });
              }
            },
            icon: const Icon(
              Icons.add,
              color: Colors.blue,
              size: 25,
            ),
          )
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      ...options.map((option) {
        return Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text('Option  : ${option['title']}'));
      }).toList(),
    ]);
  }
}
