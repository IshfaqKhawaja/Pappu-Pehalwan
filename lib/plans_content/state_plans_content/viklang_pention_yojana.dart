import 'package:flutter/material.dart';

class ViklangPentionYojana extends StatelessWidget {
  const ViklangPentionYojana({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "यू.पी विकलांग (दिव्यांग) पेंशन योजना",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Image.asset("assets/images/viklang_pention_large.jpeg"),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          ),
          Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text("यूपी विकलांग पेंशन योजना का लाभ लेने के लिए आप की आयु कम से कम 18 वर्ष की होनी चाहिए और न्यूनतम विकलांगता 40% होना अनिवार्य है। इस योजना के अंतर्गत विकलांग व्यक्तियों को 500 रुपए हर माह पेंशन के रूप में दी जाएगी। इस योजना की शुरुआत 2016 में की गयी थी और केवल उत्तर प्रदेश के निवासी ही आवेदन कर सकते है। Viklang Pension Yojana Uttar Pradesh की शुरुआत करने का कारण यही है की विकलांग व्यक्ति को आत्मनिर्भर बना सके और उसकी आर्थिक तोर पर भी सहायता की जा सके। उत्तर प्रदेश दिव्यांग पेंशन योजना के लिए पुरुष – महिलायें दोनों आवेदन कर सकते है। आवेदक 40% से अधिक दिव्यांग होना चाहिए।"))))
        ],
      ),
    );
  }
}
