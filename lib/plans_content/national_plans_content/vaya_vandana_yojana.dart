import 'package:flutter/material.dart';

class VayaVandanaYojana extends StatelessWidget {
  const VayaVandanaYojana({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "प्रधानमंत्री वय वन्दना योजना",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Image.asset("assets/images/stand_up_india.jpg"),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          ),
          Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text("प्रधानमंत्री वय वंदना योजना का शुभारंभ अनिश्चित बाजार स्थितियों के कारण 60 वर्ष से अधिक आयु के वृद्धों की ब्‍याज आय में भविष्‍य में होने वाली कमी के प्रति सुरक्षा प्रदान करने के साथ-साथ तथा उन्‍हें सामाजिक सुरक्षा उपलब्‍ध कराने के लिए किया गया था। इस योजना को भारतीय जीवन बीमा निगम (एलआईसी) के माध्‍यम से कार्यान्वित किया जा रहा है और यह योजना अभिदान के लिए 31 मार्च, 2023 तक खुली है।पीएमवीवीवाई में 10 वर्ष की पॉलिसी अवधि के लिए वित्‍तीय वर्ष 2020-21 के संबंध में 7.40% प्रतिवर्ष के प्रतिलाभ का प्रस्‍ताव किया गया है। इसके बाद के वर्षों में इस स्‍कीम के परिचालन में रहने पर इस अवसीमा की समाप्ति पर इस स्‍कीम का नए सिरे से मूल्‍यांकन करके 7.75% की अधिकतम सीमा के तथा वरिष्‍ठ नागरिक बचत योजना (एससीएसएस) प्रतिलाभ की लागू दर के अनुरूप वित्‍तीय वर्ष के 1 अप्रैल से प्रतिलाभ की सुनिश्चित दर का वार्षिक आधार पर पुनर्निर्धारण किया जाएगा।इस योजना के अंतर्गत पेंशन का भुगतान ग्राहक द्वारा दिए गए विकल्‍प के आधार पर मासिक, त्रैमासिक, अर्द्धवार्षिक अथवा वार्षिक आधार पर किया जाता है। योजना के अंतर्गत न्‍यूनतम 1000 रुपये मासिक पेंशन के लिए न्‍यूनतम खरीद मूल्‍य 1,62,162 रुपये तथा 9,250 रुपए की प्रतिमाह पेंशन राशि प्राप्‍त करने के लिए अधिकतम खरीद मूल्‍य 15 लाख रुपए प्रति वरिष्‍ठ नागरिक है।")
                  )))
        ],
      ),
    );
  }
}
