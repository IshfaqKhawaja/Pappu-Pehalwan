import 'package:flutter/material.dart';

class VidhwaPentionYojana extends StatelessWidget {
  const VidhwaPentionYojana({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "यू.पी विधवा पेंशन योजना",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Image.asset("assets/images/vidhwa_pention_large.jpeg"),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          ),
          Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text("उत्तर प्रदेश सरकार ने यह योजना निराश्रित विधवा महिलाओ के कल्याण के लिए शुरू की है | योजना का लाभ यूपी की उन गरीबी रेखा से नीचे आने वाली विधवा महिलाओ को प्राप्त होगा जिनकी उम्र 18 से 60 वर्ष होगी | UP Vidhwa Pension Scheme के अंतर्गत राज्य सरकार द्वारा प्रतिमाह दी जाने वाली 300 रूपये की पेंशन धनराशि सीधे विधवा महिलाओ के बैंक अकॉउंट में पंहुचा जाएगी इसलिए आवेदिका का बैंक खाता होना अनिवार्य है|इस योजना के तहत राज्य की जो इच्छुक विधवा महिलाए आवेदन करना चाहती है  वह UP Vidhwa Pension  Scheme की आधिकारिक वेबसाइट पर ऑनलाइन आवेदन कर सकती है और इस योजना का लाभ उठा सकती है |")
                  )))
        ],
      ),
    );
  }
}
