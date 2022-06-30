import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DisplayQuestion extends StatefulWidget {
  final question;
  final isFirstQuestion;
  final questionIndex;
  final clickable;
  final addMessagesToFirebase;
  final userDetails;
  final isFromUsersChat;
  final index;
  final messages;
  final questions;
  final optionId;
  final update;
  final removeQuestion;
  final field;
  final shoWDeleteButton;
  final datetime;
  const DisplayQuestion({
    Key? key,
    this.clickable,
    this.isFirstQuestion = false,
    this.question,
    this.questionIndex,
    this.addMessagesToFirebase,
    this.userDetails,
    this.isFromUsersChat,
    this.index,
    this.messages,
    this.optionId,
    this.questions,
    this.update,
    this.removeQuestion,
    this.field,
    this.shoWDeleteButton = true,
    this.datetime,
  }) : super(key: key);

  @override
  State<DisplayQuestion> createState() => _DisplayQuestionState();
}

class _DisplayQuestionState extends State<DisplayQuestion> {
  @override
  Widget build(BuildContext context) {
    // print(widget.question);
    final width = MediaQuery.of(context).size.width;
    return widget.question == ''
        ? const SizedBox.shrink()
        : InkWell(
            onLongPress: widget.userDetails['isAdmin'] &&
                    !widget.isFromUsersChat &&
                    widget.clickable
                ? () {
                    String tempData = '';
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return Dialog(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: widget.question,
                                      labelStyle: GoogleFonts.openSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        tempData = value;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                MaterialButton(
                                  child: Text(
                                    'Edit',
                                    style: GoogleFonts.openSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.greenAccent,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (tempData != '') {
                                      var questions = widget.questions;
                                      questions['${widget.index}']![widget
                                          .field['id']][0]['title'] = tempData;

                                      widget.addMessagesToFirebase(
                                          widget.messages, questions);
                                    }
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          );
                        }).then((value) {
                      widget.addMessagesToFirebase(
                          widget.messages, widget.questions);
                      widget.update();
                    });
                  }
                : null,
            child: Container(
              margin: EdgeInsets.only(
                left: 22,
                right: 4,
                top: 2,
                bottom: widget.isFirstQuestion ? 6 : 0,
              ),
              child:Container(
                     width: widget.userDetails['isAdmin']
                        ? width * 0.88
                        : widget.field['isMe'] == 1
                            ? width * 0.56
                            : width * 0.88,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        border: widget.isFirstQuestion ? Border.all(color: Colors.black,width: 1.5):null,
                        borderRadius: widget.isFirstQuestion
                            ? BorderRadius.circular(10)
                            : const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6)
                        )
                      ]
                    ),
                    child:  Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            widget.question,
                            style: GoogleFonts.openSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    
                  if (widget.userDetails['isAdmin'] &&
                      widget.field['id'] != '0' &&
                      !widget.isFromUsersChat &&
                      widget.shoWDeleteButton)
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: const Text('Are you sure?'),
                                  actions: [
                                    TextButton(
                                      child: const Text('Yes'),
                                      onPressed: () {
                                        widget.removeQuestion(widget.field['id']);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('No'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            ),
          );
    ;
  }
}
