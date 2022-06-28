import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auto_dialog_field.dart';
import 'auto_field_edit_options.dart';

class AutoMessageEditField extends StatefulWidget {
  final messages;
  final questions;
  final index;
  final saveData;
  final lastParentIndex;
  final id;

  const AutoMessageEditField({
    Key? key,
    this.messages,
    this.index,
    this.questions,
    this.saveData,
    this.lastParentIndex,
    this.id,
  }) : super(key: key);

  @override
  State<AutoMessageEditField> createState() => _AutoMessageEditFieldState();
}

class _AutoMessageEditFieldState extends State<AutoMessageEditField> {
  int lastQuestionIndex = -1;
  int lastOptionId = -1;
  List options = [];
  String questionText = '';
  String parentId = '';
  bool showQuestion = true;
  int questionIndex = 0;

  void addQuestionText(String queston, parentId) {
    questionText = queston;
    this.parentId = parentId;
  }

  void addOptions(String option, String id) {
    options.add(
      {
        'title': option,
        'id': id,
      },
    );
    // print('Options are : $options');
  }

  // Save data :
  void saveData() {
    widget.saveData(questionText, parentId, options, parentId);
    options = [];
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    lastQuestionIndex = widget.questions['${widget.index}'].length - 1;
    options = [];
  }

  @override
  Widget build(BuildContext context) {
    if (widget.messages[widget.index].length == 0) {
      lastOptionId = 1;
    } else {
      lastOptionId = widget.messages[widget.index].length + 1;
    }
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              ...widget.messages[widget.index].map((message) {
                if (message['id'] == widget.id) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text(message['title']),
                        trailing: Text(' Id is ${message['id']}'),
                        subtitle: Text('Parent id is ${message['parentId']}'),
                      ),
                      const Divider(),
                    ],
                  );
                } else {
                  return SizedBox.shrink();
                }
              }).toList(),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.openSans(
                    color: Colors.redAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                List<String> options = [];
                showDialog(
                    context: context,
                    builder: (c) {
                      return Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AutoDialogField(
                                addQuestionText: addQuestionText,
                                lastParentIndex: widget.lastParentIndex,
                                index: widget.index,
                                questions: widget.questions,
                                parentId: widget.index,
                              ),
                              AutoFieldEditOption(
                                addOptions: addOptions,
                                lastOptionId: lastOptionId,
                              ),
                              TextButton(
                                onPressed: saveData,
                                child: const Text('Save'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).then((value) => setState(() {}));
              },
              child: Text(
                'Add',
                style: GoogleFonts.openSans(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
