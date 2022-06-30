import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final controller = TextEditingController();
  double height = 0.0;
  double width = 0.0;
  Widget makeListWidget(title) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 3,
          backgroundColor: Colors.black,
        ),
        const SizedBox(width: 6),
        Container(
          width: 73.7,
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.montserrat(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: Color(0xff37688B)
            ),
          ),
        ),
      ],
    );
  }

  Widget makeContainerCard(title, index) {
    return InkWell(
      onTap: index > 0
          ? null
          : () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return Dialog(
                      child: Container(
                        height: height * 0.2,
                        width: width * 0.8,
                        padding: const EdgeInsets.only(top: 30, left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'किया आप सुझाव देना चाहते हैं?',
                              style: GoogleFonts.openSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'ना',
                                    style: GoogleFonts.openSans(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    List listTiles = [
                                      'पर्यटन',
                                      'नगर विकास',
                                      'महिला सुरक्षा',
                                      'स्वच्छ भारत',
                                      'अन्य',
                                    ];
                                    Navigator.of(context).pop();
                                    showCupertinoModalPopup(
                                        context: context,
                                        builder: (ctx) {
                                          return Material(
                                            animationDuration:
                                                const Duration(seconds: 1),
                                            child: Container(
                                              width: width,
                                              height: height * 0.5,
                                              child: ListView(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      'इनमे से कोई एक विकल्प चुने',
                                                      style:
                                                          GoogleFonts.openSans(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  ...List.generate(
                                                      listTiles.length,
                                                      (index) {
                                                    return ListTile(
                                                      title: Card(
                                                        elevation: 5,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 20,
                                                                  top: 20,
                                                                  left: 10,
                                                                  right: 10),
                                                          child: Text(
                                                            listTiles[index],
                                                            style: GoogleFonts
                                                                .openSans(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        setState(() {
                                                          controller.text =
                                                              listTiles[index];
                                                        });
                                                      },
                                                    );
                                                  }),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Text(
                                    'हाँ',
                                    style: GoogleFonts.openSans(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
      child: Container(
        height: 27,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        margin: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 5,
                offset: const Offset(0, 3))
          ],
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          title,
          style: GoogleFonts.openSans(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: Colors.green,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    Widget spaceWidget = const SizedBox(
      height: 10,
    );
    int index = -1;
    var listTitles = const [
      // 'पर्यटन अवसंरचना विकास',
      // 'मानव संसाधन विकास',
      // 'होटल और रेस्तरां',
      // 'प्रचार और विपणन',
      // 'यात्रा व्‍यवसाय',
      // 'बाजार अनुसंधान और सांख्यिकी',
      'ऑडियो रिकॉर्डिंग',
      'उपयुक्त श्रेणी चुनकर',
      'मैसेज द्वारा',
      'महिला हेल्‍पलाइन नंबर',
      // 'वीडियो कॉल',
      // 'हेल्पलाइन नंबर',
    ];
    var cardTitles = [
      // 'सुविधा',
      // 'सुरक्षा',
      // 'सहयोग',
      // 'समरचना',
      // 'विकास',
      // 'प्रतीक्षा',
      // 'क्षेत्र',
      // 'निर्माण',
      //  'पर्यटन संबंधी सुझाव',
      //  'पर्यटन संबंधी शिकायत',
      //  'मैनपुरी संबंधी सुझाव',
      //  'मैनपुरी संबंधी समस्या',
      //  'सामाजिक समस्या',
      //  'व्यक्तिगत समस्या',
      //  'अन्य' ,
      'सुझाव',
      'शिकायत',
      'समस्या',
      'जानकारी दें',
      'हमसे जुड़े',
      'अन्य'
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //Upper Pappu pehalwan Image Part:
        Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 2,
              offset: const Offset(1.0, 2.0),
            )
          ]),
          margin: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 20,
          ),
          padding: const EdgeInsets.only(
            right: 10,
          ),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Container(
                    color: const Color(0xffbbc8d5),
                    child: Image.asset(
                      'assets/images/icon.jpg',
                      height: 110,
                      width: 145,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    child: Column(
                      children: [
                        Text(
                          'पप्पू पहलवान',
                          style: GoogleFonts.openSans(
                            color: Color(0xff37688B),
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        // Text(
                        //   'आपकी मदद के लिए',
                        //   style: GoogleFonts.openSans(
                        //     color: Theme.of(context).primaryColor,
                        //     fontSize: 10,
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spaceWidget,
                  Container(
                    child: Text(
                      'आप अपने सुझाव अथवा समस्या हमें निम्नलिखित माध्यम से पंहुचा सकते हैं',
                      style: GoogleFonts.openSans(
                        fontSize: 11,
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  spaceWidget,
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            makeListWidget(listTitles[0]),
                            makeListWidget(listTitles[2]),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            makeListWidget(listTitles[1]),
                            makeListWidget(listTitles[3]),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 28,
                      right: 4,
                    ),
                    color: Colors.black,
                    height: 2,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 3,
                      right: 0,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'हम आपकी सेवा के लिए तत्पर हैं और आपकी समस्या को जल्द से जल्द हल करेंगे',
                      style: GoogleFonts.openSans(
                        fontSize: 10,
                        color: Color(0xFF545454),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
