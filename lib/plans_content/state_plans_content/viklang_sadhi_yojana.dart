import 'package:flutter/material.dart';

class ViklangSadhiYojana extends StatelessWidget {
  const ViklangSadhiYojana({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "यू.पी विकलांग शादी अनुदान योजना",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Image.asset("assets/images/viklang_sadhi_large.jpeg"),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          ),
          Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text("दिव्यांग शादी विवाह प्रोत्साहन योजना को प्रदेश के नागरिकों की आर्थिक सहायता करने के लिए आरंभ किया गया था। इस योजना के अंतर्गत आवेदन प्रक्रिया विभाग द्वारा आरंभ कर दी गई है। यदि आप इस योजना का लाभ उठाना चाहते हैं तो आप इस योजना के अंतर्गत आवेदन कर सकते हैं। आवेदन प्रक्रिया आरंभ होने की जानकारी विभाग द्वारा सभी दिव्यांग नागरिकों को दी गई है। इस योजना के अंतर्गत यदि दिव्यांग दंपत्ति में से पुरुष दिव्यांग है तो ₹15000 की आर्थिक सहायता एवं महिला दिव्यांग है तो ₹20000 की आर्थिक सहायता प्रदान की जाएगी।\n\nयदि महिला और पुरुष दोनों दिव्यांग है तो दिव्यांगजन शादी विवाह प्रोत्साहन योजना के माध्यम से ₹35000 की आर्थिक सहायता प्रदान की जाएगी। वह सभी नागरिक जो इस योजना के अंतर्गत आवेदन करना चाहते हैं वह आधिकारिक वेबसाइट पर जाकर आवेदन कर सकते हैं। आवेदन करते समय आवेदक को दिव्यांगता प्रदर्शित करने वाला संयुक्त नवीनतम फोटो, आयु प्रमाण पत्र, जाति प्रमाण पत्र, आय प्रमाण पत्र, विवाह पंजीकरण प्रमाण पत्र एवं सक्षम अधिकारी द्वारा निर्गत दिव्यांग प्रमाण पत्र जमा करना होगा।"))))
        ],
      ),
    );
  }
}
