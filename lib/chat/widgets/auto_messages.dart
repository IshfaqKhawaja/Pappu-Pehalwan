import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../chat/chat_screen.dart';
import 'audio_bubble.dart';
import 'display_question.dart';
import 'make_container.dart';
import 'show_image_bubble.dart';
import 'show_video_bubble.dart';
import '../../providers/user_details.dart';
import 'package:provider/provider.dart';

class AutoMessages extends StatefulWidget {
  final userId;
  final changeShowInputMessageField;
  final index;
  final isFromUsersChat;
  final details;
  final questions;
  final scaffoldKey;
  final appBarTitle;
  final isFileSending;
  final isImage;
  final isAudio;
  final isVideo;
  final file;
  final datetime;
  final isFromChatScreen;
  const AutoMessages({
    Key? key,
    this.userId,
    this.changeShowInputMessageField,
    this.index = 1,
    this.details = const [],
    this.questions = const {},
    this.scaffoldKey,
    this.isFromUsersChat = false,
    this.appBarTitle,
    this.isFileSending = false,
    this.isImage = false,
    this.isAudio = false,
    this.isVideo = false,
    this.file,
    this.datetime,
    this.isFromChatScreen,
  }) : super(key: key);

  @override
  State<AutoMessages> createState() => AutoMessagesState();
}

class AutoMessagesState extends State<AutoMessages> {
  var userDetails = {};
  List messages = [
    [],
    [],
  ];

  Map<String, Map<String, List<Map<String, dynamic>>>> questions = {
    '0': {
      // Question 0
      '0': [
        {
          'title': 'मैं पप्पू पहलवान आपकी किस प्रकार से सहायता कर सकता हूँ',
          'parentId': '0',
          'isQuestion': true,
          'id': '0',
        },
      ],
    },
    '1': {
      '0': [
        {
          'title': 'मैं पप्पू पहलवान आपकी किस प्रकार से सहायता कर सकता हूँ',
          'parentId': '0',
          'isQuestion': true,
          'id': '0',
        },
      ],
    },
  };

  String parentId = '0';
  String docId = '';
  int questionIndex = 1;
  int optionId = 0;
  List categorySelected = [];
  double height = 0;
  double width = 0;
  List messageFields = [];
  List previousMessageFields = [];
  bool messageSent = false;
  bool hideButtons = false;
  bool replying = false;
  bool loading = false;
  ScrollController controller = ScrollController();
  bool initialClick = true;
  bool displayMessage = false;
  bool saveChats = false;
  int index = 0;
  bool showReplyAgain = false;

  void changeShowReplyAgain(bool value) {
    setState(() {
      showReplyAgain = value;
    });
  }

  void updateInitialClick() {
    setState(() {
      initialClick = false;
    });
  }

  // Utility Functions :
  void saveData(questionText, questionId, parentId, options, optionId) {
    String i = '${questionId + 1}$optionId';
    print(i);
    // First Remove all Options
    messages[index].removeWhere((element) => element['questionId'] == i);
    // Add new Options:
    for (var option in options) {
      messages[index].add({
        'title': option['title'],
        'parentId': parentId,
        'id': option['id'],
        'isMe': 0,
        'questionId': i,
      });

      questions['$index']![i] = [
        {
          'title': questionText,
          'isQuestion': true,
          'parentId': parentId,
          'id': i,
        }
      ];
    }
    addMessagesToFirebase(messages, questions);
    // print('Questions are ${questions['$index']}');
    // print('Messages are $messages');
    setState(() {});
  }

  void removeQuestion(index) {
    questions['${this.index}']!.remove(index);
    messages[this.index]!
        .removeWhere((element) => element['questionId'] == index);
    addMessagesToFirebase(messages, questions);
    previousMessageFields = [];
    messageFields = [];
    questionIndex = 1;
    optionId = 0;
    parentId = '${this.index}';
    update();
  }

  void addMessagesToFirebase(mesages, questions) async {
    try {
      FirebaseFirestore.instance.collection('messages').doc('messages').set({
        'messages0': messages[0],
        'messages1': messages[1],
        'questions': questions,
      });
    } catch (e) {
      print(e);
    }
  }

  void getDataFromFirebase() {
    try {
      FirebaseFirestore.instance
          .collection('messages')
          .doc('messages')
          .get()
          .then((value) {
        if (value.exists) {
          final data = value.data()!;
          setState(() {
            loading = false;
            messages = [
              data.containsKey('messages0') ? data['messages0'] : [],
              data.containsKey('messages1') ? data['messages1'] : [],
            ];
            if (data.containsKey('questions')) {
              (data['questions']['0'] as Map<String, dynamic>)
                  .forEach((key, value) {
                for (var i in value) {
                  questions['0']![key] = [i];
                }
              });
              (data['questions']['1'] as Map<String, dynamic>)
                  .forEach((key, value) {
                for (var i in value) {
                  questions['1']![key] = [i];
                }
              });
            }
          });
        }
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
      print(e);
    }
  }

  // Utitlity Functions
  void addData(Map<String, dynamic> field, questionId, ind, optionId) {
    String i = '${questionId + 1}$optionId';

    setState(() {
      parentId = field['id'];
      previousMessageFields.addAll(messageFields);
      categorySelected.add(field['title']);
      messageFields = [];
      questionIndex += 1;
      optionId = index;
      var tempField = field.map((key, value) {
        if (key == 'isMe') {
          return MapEntry(key, 1);
        } else {
          return MapEntry(key, value);
        }
      });

      previousMessageFields.add(tempField);
      if (questions['$index']!.containsKey(i)) {
        previousMessageFields.add(questions['$index']![i]![0]);
      }
      // print('Previous Message Field is $previousMessageFields');
    });
  }

  void scrollAnimateToEnd() {
    try {
    } catch (e) {
      print('error on scroll $e');
    }
    // });
  }

  void changeMessageSent(String docId) async {
    FocusScope.of(context).unfocus();
    var res = await FirebaseFirestore.instance
        .collection('suggestions')
        .doc(widget.userId)
        .collection('messages')
        .doc(docId)
        .get();

    setState(() {
      messageSent = true;
      hideButtons = true;
      this.docId = docId;
      previousMessageFields = res.data()!['details'];
    });
  }

  void update() {
    setState(() {});
  }

  Widget replyAgain(String title, {isFirst = false}) {
    const Color background = Color(0xFF626262);
    const Color fill = Colors.white;
    final List<Color> gradient = [
      background,
      background,
      fill,
      fill,
    ];
    const double fillPercent = 50;
    const double fillStop = (100 - fillPercent) / 100;
    final List<double> stops = [0.0, fillStop, fillStop, 1.0];
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      height: 95,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: gradient,
              stops: stops,
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black.withOpacity(0.4))),
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          changeShowReplyAgain(false);
                          widget.changeShowInputMessageField(true);
                          if (isFirst) {
                            setState(() {
                              hideButtons = true;
                              displayMessage = true;
                              previousMessageFields.add({
                                'title': categorySelected.isNotEmpty
                                    ? 'आप हमें अपना ${categorySelected.last} संबंधी सुझाव नीचे दिए विकल्प की सहायता से भेज सकते है।'
                                    : '',
                                'isQuestion': true,
                                'doNotDelete': true,
                                'notClickable': false,
                              });
                            });
                          }
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check,
                              size: 20,
                              color: Colors.green,
                            ),
                            Text(
                              "हाँ",
                              style: GoogleFonts.openSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green),
                            ),
                          ],
                        )),
                    Container(
                      padding: const EdgeInsets.only(top: 1.5),
                      height: 47,
                      child: const VerticalDivider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          Fluttertoast.showToast(
                            msg:
                                "धन्यवाद हम आपकी समस्या को जल्द से जल्द हल करने की कोशिश करेंगे !",
                            gravity: ToastGravity.BOTTOM,
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.black.withOpacity(0.7),
                            textColor: Colors.white,
                            fontSize: 13,
                          );
                          await Future.delayed(
                              const Duration(milliseconds: 2500));
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.clear_rounded,
                              size: 20,
                              color: Colors.red,
                            ),
                            Text(
                              "नहीं",
                              style: GoogleFonts.openSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red),
                            ),

                          ],
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    index = widget.index;
    parentId = '$index';
    userDetails =
        Provider.of<UserDetails>(context, listen: false).getUserDetails;
    getDataFromFirebase();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void createDelay(bool value) async {
    setState(() {
      replying = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    bool isPostAddedToMessageFields = false;

    // print(index);
    // print(userDetails);

    // print(questions['$index']);
    // print(messages[index]);
    if (!widget.isFromUsersChat) {
      messageFields = [];
      for (var i in messages[index]) {
        // print(i);
        if (i['parentId'] == parentId) {
          messageFields.add(i);
          isPostAddedToMessageFields = true;
        }
      }
    } else {
      previousMessageFields = widget.details;
      (widget.questions['0'] as Map<String, dynamic>).forEach((key, value) {
        for (var i in value) {
          questions['0']![key] = [i];
        }
      });
      (widget.questions['1'] as Map<String, dynamic>).forEach((key, value) {
        for (var i in value) {
          questions['1']![key] = [i];
        }
      });
      index = widget.appBarTitle == 'शिकायत' ? 0 : 1;
      // print(questions);

      messageFields = [];
      widget.changeShowInputMessageField(true);
    }
    // print(questions['$index']);
    // print(messageFields);
    // print(userDetails['phoneNumber']);
    // scrollAnimateToEnd();
    // print(questions['$index']);

    return !widget.isFromUsersChat && loading
        ? Center(
            child: Container(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ))
        : WillPopScope(
            onWillPop: () async {
              if (widget.isFromUsersChat) {
                return true;
              }
              bool value = true;
              await showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      content: const Text('Are You Sure?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();

                            value = true;
                          },
                          child: const Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            value = false;
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('No'),
                        ),
                      ],
                    );
                  });
              return value;
            },
            child: Scaffold(
              appBar: null,
              extendBodyBehindAppBar: true,
              body: SingleChildScrollView(
                controller: controller,
                reverse: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!widget.isFromUsersChat && initialClick)
                      const ChatScreen(),
                    if (!widget.isFromUsersChat &&
                        userDetails['isAdmin'] &&
                        (userDetails['phoneNumber'] == '+91 6006604186' ||
                            userDetails['phoneNumber'] == '+91 1234567890'))
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    title: const Text(
                                        'Are you sure you want to delete all messages?'),
                                    actions: [
                                      TextButton(
                                        child: const Text('Yes'),
                                        onPressed: () async {
                                          questions['$index'] = {
                                            '0': [
                                              {
                                                'title':
                                                    'मैं पप्पू पहलवान आपकी किस प्रकार से सहायता कर सकता हूँ',
                                                'parentId': '0',
                                                'isQuestion': true,
                                                'id': '0',
                                              },
                                            ],
                                          };

                                          messages[index] = [];
                                          messageFields = [];
                                          parentId = '0';
                                          docId = '';
                                          questionIndex = 1;
                                          optionId = 0;
                                          categorySelected = [];
                                          height = 0;
                                          width = 0;
                                          previousMessageFields = [];
                                          messageSent = false;
                                          hideButtons = false;
                                          replying = false;
                                          loading = false;
                                          addMessagesToFirebase(
                                              messages, questions);
                                          Navigator.of(ctx).pop();
                                          setState(() {});
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('No'),
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Text(
                            'Clear',
                            style: GoogleFonts.openSans(
                              color: Colors.redAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    if (!widget.isFromUsersChat)
                      if (questions['$index']!.containsKey('0'))
                        DisplayQuestion(
                          question: questions['$index']!['0']![0]['title'],
                          addMessagesToFirebase: addMessagesToFirebase,
                          clickable: true,
                          index: index,
                          isFirstQuestion: true,
                          isFromUsersChat: widget.isFromUsersChat,
                          messages: messages,
                          questions: questions,
                          userDetails: userDetails,
                          optionId: optionId,
                          questionIndex: 0,
                          update: update,
                          removeQuestion: removeQuestion,
                          field: questions['$index']!['0']![0],
                          datetime: widget.datetime,
                        ),
                    if (questions['$index']!.containsKey('1$index'))
                      DisplayQuestion(
                        question: questions['$index']!['1$index']![0]['title'],
                        addMessagesToFirebase: addMessagesToFirebase,
                        clickable: true,
                        index: index,
                        isFirstQuestion: false,
                        isFromUsersChat: widget.isFromUsersChat,
                        messages: messages,
                        questions: questions,
                        userDetails: userDetails,
                        optionId: optionId,
                        questionIndex: 1,
                        update: update,
                        removeQuestion: removeQuestion,
                        field: questions['$index']!['1$index']![0],
                        datetime: widget.datetime,
                      ),
                    ...List.generate(previousMessageFields.length, (i) {
                      return MakeContainer(
                        addData: addData,
                        addMessagesToFirebase: addMessagesToFirebase,
                        clickable: false,
                        controller: controller,
                        field: previousMessageFields[i],
                        index: i,
                        isFromUsersChat: widget.isFromUsersChat,
                        messages: messages,
                        questions: questions,
                        userDetails: userDetails,
                        optionId: optionId,
                        questionIndex: questionIndex,
                        update: update,
                        isFirstQuestion: false,
                        scrollAnimateToEnd: scrollAnimateToEnd,
                        screenIndex: index,
                        removeQuestion: removeQuestion,
                        saveData: saveData,
                        createDelay: createDelay,
                        updateInitialClick: updateInitialClick,
                        datetime: widget.datetime,
                        isFromChatScreen: widget.isFromChatScreen,
                      );
                    }),
                    ...List.generate(
                      messageFields.length,
                      (i) => MakeContainer(
                        addData: addData,
                        addMessagesToFirebase: addMessagesToFirebase,
                        clickable: true,
                        controller: controller,
                        field: messageFields[i],
                        index: i,
                        isFromUsersChat: widget.isFromUsersChat,
                        messages: messages,
                        questions: questions,
                        userDetails: userDetails,
                        optionId: optionId,
                        questionIndex: questionIndex,
                        update: update,
                        isFirstQuestion: false,
                        scrollAnimateToEnd: scrollAnimateToEnd,
                        screenIndex: index,
                        removeQuestion: removeQuestion,
                        saveData: saveData,
                        createDelay: createDelay,
                        updateInitialClick: updateInitialClick,
                        datetime: widget.datetime,
                        isFromChatScreen: widget.isFromChatScreen,
                      ),
                    ),
                    if (replying)
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator()),
                            SizedBox(
                              width: 30,
                            )
                          ],
                        ),
                      ),
                    if (!isPostAddedToMessageFields &&
                        !hideButtons &&
                        !widget.isFromUsersChat &&
                        categorySelected.isNotEmpty)
                      Column(
                        children: [
                          // const SizedBox(height: 20),
                          replyAgain(
                            'क्या आप ${categorySelected.last} संबंधी सुझाव देना चाहते हैं?',
                            isFirst: true,
                          ),
                        ],
                      ),
                    if (widget.isFileSending)
                      Align(
                        alignment: widget.userId ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            widget.isImage
                                ? ShowImageBubble(
                                    url: widget.file,
                                    datetime: DateTime.now().toIso8601String(),
                                    isMe: widget.userId ==
                                        FirebaseAuth.instance.currentUser!.uid,
                                    read: 0,
                                    isNetwork: false,
                                  )
                                : widget.isAudio
                                    ? AudioBubble(
                                        url: widget.file,
                                        datetime:
                                            DateTime.now().toIso8601String(),
                                        isMe: widget.userId ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                        read: 0,
                                        isNetwork: false,
                                      )
                                    : widget.isVideo
                                        ? ShowVideoBubble(
                                            url: widget.file,
                                            datetime: DateTime.now()
                                                .toIso8601String(),
                                            isMe: widget.userId ==
                                                FirebaseAuth
                                                    .instance.currentUser!.uid,
                                            read: 0,
                                            isNetwork: false,
                                          )
                                        : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    if (showReplyAgain)
                      replyAgain("क्या आप कोई सन्देश लिखना चाहते हैं"),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              floatingActionButton: userDetails['isAdmin'] &&
                      questions['$index']!.length <= 1
                  ? FloatingActionButton(
                      heroTag: null,
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (ctx) {
                              return MakeContainer(
                                addData: addData,
                                addMessagesToFirebase: addMessagesToFirebase,
                                clickable: true,
                                controller: controller,
                                index: 0,
                                isFromUsersChat: widget.isFromUsersChat,
                                userDetails: userDetails,
                                optionId: optionId,
                                update: update,
                                isFirstQuestion: false,
                                scrollAnimateToEnd: scrollAnimateToEnd,
                                removeQuestion: removeQuestion,
                                isInitial: true,
                                screenIndex: index,
                                questions: questions,
                                messages: messages,
                                questionIndex: 0,
                                field: {'id': '$index'},
                                saveData: saveData,
                                createDelay: createDelay,
                                updateInitialClick: updateInitialClick,
                                datetime: widget.datetime,
                                isFromChatScreen: widget.isFromChatScreen,
                              );
                            }).then((value) {
                          // print(messages);
                          setState(() {});
                        });
                      },
                      child:
                          const Icon(Icons.edit, color: Colors.white, size: 30))
                  : null,
            ),
          );
  }
}
