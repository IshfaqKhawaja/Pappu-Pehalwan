import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AutoDialogField extends StatefulWidget {
  final addQuestionText;
  final lastParentIndex;
  final index;
  final questions;
  final parentId;
  final questionIndex;
  const AutoDialogField({
    Key? key,
    this.addQuestionText,
    this.lastParentIndex,
    this.index,
    this.questions,
    this.parentId,
    this.questionIndex,
  }) : super(key: key);

  @override
  State<AutoDialogField> createState() => _AutoDialogFieldState();
}

class _AutoDialogFieldState extends State<AutoDialogField> {
  final _formKey = GlobalKey<FormState>();
  String questionText = '';
  String parentId = '';
  bool showQuestion = true;
  int dropDownMenuItemIndex = 0;
  int questionIndex = 0;
  List menuItems = [];

  @override
  void initState() {
    super.initState();
    parentId = widget.parentId.toString();
   questionIndex =  widget.questionIndex + 1;
  }

  @override
  Widget build(BuildContext context) {
   
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showQuestion) const Text('Question'),
            if (showQuestion)
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        label: Text('Enter Question'),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter question';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        questionText = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  
                  TextButton(
                      onPressed: () {
                        if (questionText != '' && parentId != '') {
                          widget.addQuestionText(questionText, parentId);
                          setState(() {
                            showQuestion = false;
                          });
                        }
                      },
                      child: Text(
                        'Add',
                        style: GoogleFonts.openSans(
                            color: Colors.blue,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            if (questionText != '' && parentId != '')
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text('Question : $questionText')),
                  const SizedBox(
                    width: 10,
                  ),
                  // Text(parentId),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
