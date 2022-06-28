import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'audio_bubble.dart';
import 'auto_dialog_field.dart';
import 'auto_field_edit_options.dart';
import 'display_question.dart';
import 'show_image_bubble.dart';
import 'show_video_bubble.dart';

class MakeContainer extends StatefulWidget {
  final field;
  final index;
  final clickable;
  final addMessagesToFirebase;
  final isFromUsersChat;
  final messages;
  final questions;
  final optionId;
  final update;
  final userDetails;
  final isFirstQuestion;
  final questionIndex;
  final scrollAnimateToEnd;
  final controller;
  final addData;
  final screenIndex;
  final removeQuestion;
  final saveData;
  final isInitial;
  final createDelay;
  final updateInitialClick;
  final datetime;
  final showDate;
  final isFromChatScreen;

  const MakeContainer({
    Key? key,
    this.clickable,
    this.controller,
    this.addData,
    this.field,
    this.index,
    this.addMessagesToFirebase,
    this.isFirstQuestion,
    this.isFromUsersChat,
    this.scrollAnimateToEnd,
    this.messages,
    this.optionId,
    this.questionIndex,
    this.questions,
    this.update,
    this.userDetails,
    this.screenIndex,
    this.removeQuestion,
    this.saveData,
    this.isInitial = false,
    this.createDelay,
    this.updateInitialClick,
    this.datetime,
    this.showDate = true,
    this.isFromChatScreen,
  }) : super(key: key);

  @override
  State<MakeContainer> createState() => _MakeContainerState();
}

class _MakeContainerState extends State<MakeContainer> {
  int lastQuestionIndex = -1;
  int lastOptionId = -1;
  List options = [];
  String questionText = '';
  String parentId = '';
  bool showQuestion = true;
  var datetime;
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
    widget.saveData(questionText, widget.questionIndex, parentId, options,
        widget.field['id']);
    options = [];
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    lastQuestionIndex = widget.questions['${widget.screenIndex}'].length - 1;
    options = [];
    // print(widget.field);
    if (widget.field.containsKey('createdAt')) {
      datetime = widget.field['createdAt'];
    } else {
      datetime = Timestamp.now();
    }

    //  else  if (!widget.isFromUsersChat) {
    //     datetime = Timestamp.now();
    //   } else {
    //     datetime = widget.datetime;
    //   }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    var lastParentIndex = widget.messages[widget.screenIndex].isNotEmpty
        ? int.parse(widget.messages[widget.screenIndex].last['id'])
        : 1;
    // print('last parent id $lastParentIndex');

    return widget.isInitial && widget.userDetails['isAdmin']
        ? Dialog(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AutoDialogField(
                    addQuestionText: addQuestionText,
                    lastParentIndex: lastParentIndex,
                    index: widget.index,
                    questions: widget.questions,
                    questionIndex: widget.questionIndex,
                    parentId: widget.field['id'],
                  ),
                  AutoFieldEditOption(
                    addOptions: addOptions,
                    lastOptionId: lastParentIndex,
                    questionIndex: widget.questionIndex,
                  ),
                  TextButton(
                    onPressed: saveData,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          )
        : widget.field.containsKey('isQuestion')
            ? DisplayQuestion(
                question: widget.field['title'],
                field: widget.field,
                addMessagesToFirebase: widget.addMessagesToFirebase,
                clickable:
                    widget.field.containsKey('notClickable') ? false : true,
                index: widget.screenIndex,
                isFirstQuestion: false,
                isFromUsersChat: widget.isFromUsersChat,
                messages: widget.messages,
                questions: widget.questions,
                userDetails: widget.userDetails,
                optionId: widget.optionId,
                questionIndex: widget.questionIndex,
                update: widget.update,
                removeQuestion: widget.removeQuestion,
                shoWDeleteButton:
                    widget.field.containsKey('doNotDelete') ? false : true,
              )
            : InkWell(
                onDoubleTap: widget.clickable && widget.userDetails['isAdmin']
                    ? () {
                        // print('Question Index is ${widget.questionIndex}');

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
                                        lastParentIndex: lastParentIndex,
                                        index: widget.index,
                                        questions: widget.questions,
                                        questionIndex: widget.questionIndex,
                                        parentId: widget.field['id'],
                                      ),
                                      AutoFieldEditOption(
                                        addOptions: addOptions,
                                        lastOptionId: lastParentIndex,
                                        questionIndex: widget.questionIndex,
                                      ),
                                      TextButton(
                                        onPressed: saveData,
                                        child: const Text('Save'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    : null,
                onLongPress: widget.userDetails['isAdmin'] &&
                        widget.field['isMe'] == 0 &&
                        !widget.isFromUsersChat
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
                                          labelText: widget.field['title'],
                                          labelStyle: GoogleFonts.openSans(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          // print(field);
                                          widget.messages[widget.screenIndex]
                                              .where((element) =>
                                                  element['id'] ==
                                                  widget.field['id'])
                                              .toList()[0]['title'] = tempData;
                                          widget.addMessagesToFirebase(
                                              widget.messages,
                                              widget.questions);

                                          //   .forEach((element) {
                                          // element['title'] = tempData;
                                          // });
                                          // print(messages[widget.index]);
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
                onTap: widget.clickable
                    ? () async {
                        widget.createDelay(true);
                        await Future.delayed(
                            const Duration(milliseconds: 1000));
                        widget.createDelay(false);

                        widget.addData(widget.field, widget.questionIndex,
                            widget.index, widget.field['id']);
                        // widget.scrollAnimateToEnd();

                        widget.updateInitialClick();
                      }
                    : null,
                child: widget.field.containsKey('type')
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: widget.field['isMe'] == 1 ? 10 : 0,
                            ),
                            child: Row(
                              mainAxisAlignment: widget.field['isMe'] == 0
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // if (widget.isFromChatScreen &&
                                //     widget.field.containsKey('createdAt') &&
                                //     widget.userDetails['isAdmin'] &&
                                //     widget.field['isMe'] == 0)
                                //   Row(
                                //     children: const [
                                //       SizedBox(
                                //         width: 10,
                                //       ),
                                //       CircleAvatar(
                                //         backgroundImage: AssetImage(
                                //           'assets/images/appBarImage.png',
                                //         ),
                                //         radius: 20,
                                //       ),
                                //     ],
                                //   ),
                                widget.field['type'] == 'text'
                                    ? Container(
                                        width: width * 0.45,
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 1,
                                          horizontal: 10,
                                        ).copyWith(
                                          left: widget.isFromChatScreen &&
                                                  widget.field
                                                      .containsKey('createdAt')
                                              ? 10
                                              : 50,
                                              bottom: 4,
                                        ),
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                            color: widget.field['isMe'] == 0
                                                ? Colors.white
                                                : Colors.grey,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 1))
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            // border: Border.all(
                                            //   color: Colors.grey,
                                            //   width: 1,
                                            // ),
                                            ),
                                        child: Text(
                                          widget.field['title'],
                                          style: GoogleFonts.openSans(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                            color: widget.field['isMe'] == 0
                                                ? Colors.green
                                                : Colors.white,
                                          ),
                                        ),
                                      )
                                    : widget.field['type'] == 'image'
                                        ? ShowImageBubble(
                                            url: widget.field['attachment'],
                                            datetime: widget.field['date'],
                                            isMe: widget.field['isMe'] == 1
                                                ? true
                                                : false,
                                            read: 1,
                                          )
                                        : widget.field['type'] == 'video'
                                            ? ShowVideoBubble(
                                                url: widget.field['attachment'],
                                                datetime: widget.field['date'],
                                                isMe: widget.field['isMe'] == 1
                                                    ? true
                                                    : false,
                                                read: 1,
                                              )
                                            : widget.field['type'] == 'audio'
                                                ? AudioBubble(
                                                    url: widget
                                                        .field['attachment'],
                                                    datetime:
                                                        widget.field['date'],
                                                    isMe:
                                                        widget.field['isMe'] ==
                                                                1
                                                            ? true
                                                            : false,
                                                    read: 1,
                                                    isNetwork: true,
                                                  )
                                                : const SizedBox.shrink(),
                                // if (widget.field['isMe'] == 1)
                                //   Row(
                                //     children: [
                                //       CircleAvatar(
                                //         backgroundImage: widget.userDetails
                                //                 .containsKey('profileUrl')
                                //             ? CachedNetworkImageProvider(
                                //                 widget.userDetails[
                                //                         'profileUrl'] ??
                                //                     '')
                                //             : Image.asset(
                                //                     'assets/images/default.jpg')
                                //                 .image,
                                //       ),
                                //       const SizedBox(
                                //         width: 10,
                                //       )
                                //     ],
                                //   ),
                              ],
                            ),
                          ),
                          // if (widget.isFromUsersChat)
                            if (widget.field.containsKey('createdAt') &&
                                widget.showDate)
                              const SizedBox(
                                height: 0,
                              ),
                          // if (widget.isFromUsersChat)
                            if (widget.field.containsKey('createdAt') &&
                                widget.showDate)
                              Align(
                                alignment: widget.field['isMe'] == 0
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                                child: Row(
                                  mainAxisAlignment: widget.field['isMe'] == 0
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      DateFormat().add_E().format(
                                            datetime!.toDate(),
                                          ),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      DateFormat().add_jm().format(
                                            widget.field
                                                    .containsKey('createdAt')
                                                ? widget.field['createdAt']
                                                    .toDate()
                                                : datetime!.toDate(),
                                          ),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                              ),
                          // if (widget.isFromUsersChat)
                            if (widget.field.containsKey('createdAt') &&
                                widget.showDate)
                              const SizedBox(
                                height: 6,
                              ),
                        ],
                      )

                    // For local Messages:
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // if (widget.isFromChatScreen &&
                          //     widget.field.containsKey('createdAt') &&
                          //     widget.userDetails['isAdmin'] &&
                          //     widget.field['isMe'] == 0)
                          //   Row(
                          //     children: const [
                          //       SizedBox(
                          //         width: 10,
                          //       ),
                          //       CircleAvatar(
                          //         backgroundImage: AssetImage(
                          //           'assets/images/appBarImage.png',
                          //         ),
                          //         radius: 20,
                          //       ),
                          //     ],
                          //   ),
                          Row(
                              mainAxisAlignment: widget.field['isMe'] == 0
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: widget.field['isMe'] == 1
                                      ? width * 0.56
                                      : width * 0.88,
                                  margin: const EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 10)
                                      .copyWith(
                                    left: widget.isFromChatScreen &&
                                            widget.field
                                                .containsKey('createdAt')
                                        ? 10
                                        : 22,
                                    top: widget.field['isMe'] == 1 ? 10 : 0,
                                  ),
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: widget.field['isMe'] == 0
                                          ? Colors.white
                                          : Colors.grey,
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            blurRadius: 2,
                                            offset: const Offset(0, 1))
                                      ],
                                      borderRadius: widget.field['isMe'] == 1
                                          ? BorderRadius.circular(10)
                                          : BorderRadius.zero,
                                      // border: Border.all(
                                      //   color: Theme.of(context).primaryColor,
                                      //   width: 1,
                                      // ),
                                      ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.field['title'],
                                        style: GoogleFonts.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                          color: widget.field['isMe'] == 0
                                              ? Colors.green
                                              : Colors.white,
                                        ),
                                      ),
                                      if (widget.field['isMe'] == 0)
                                        const Icon(Icons.arrow_forward_ios,
                                            size: 12, color: Colors.red,)
                                    ],
                                  ),
                                ),
                                // if (widget.field['isMe'] == 1)
                                //   Row(
                                //     children: [
                                //       CircleAvatar(
                                //         backgroundImage: widget.userDetails
                                //                 .containsKey('profileUrl')
                                //             ? CachedNetworkImageProvider(
                                //                 widget.userDetails[
                                //                         'profileUrl'] ??
                                //                     '')
                                //             : Image.asset(
                                //                     'assets/images/default.jpg')
                                //                 .image,
                                //       ),
                                //       const SizedBox(
                                //         width: 10,
                                //       )
                                //     ],
                                //   ),
                              ]),
                          if (widget.field['isMe'] == 1 && widget.showDate)
                            const SizedBox(
                              height: 1,
                            ),
                          if (widget.field['isMe'] == 1 && widget.showDate)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  DateFormat().add_E().format(
                                        datetime!.toDate(),
                                      ),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  DateFormat().add_jm().format(
                                        datetime!.toDate(),
                                      ),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                        ],
                      ),
              );
  }
}
