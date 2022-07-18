import 'package:flutter/material.dart';

class PmMudaraYojana extends StatelessWidget {
  const PmMudaraYojana({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'प्रधानमंत्री मुद्रा योजना',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Image.asset("assets/images/Pradhan_Mantri_Mudra_Yojana.jpg"),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          ),
          Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text("योजना 8 अप्रैल, 2015 को आरंभ की गई थी। योजना के अंतर्गत उप-योजना ‘शिशु’ के तहत 50,000 रूपये तक का ऋण; उप-योजना ‘किशोर’ के तहत 50,000 रूपये से 5.0 लाख रूपये तक का ऋण; और उप-योजना ‘तरुण’ के तहत 5.0 लाख रूपये से 10.0 लाख रूपये तक का ऋण दिया जाता है। इस ऋण को प्राप्तं करने हेतु संपार्श्विक की आवश्य.कता नहीं है। इन उपायों का लक्ष्यज उन युवा, शिक्षित या कुशल कामगारों का विश्वा्स बढ़ाना है जो अब प्रथम पीढ़ी उद्यमी बनने की आकांक्षा पूरी कर सकेंगे; वर्तमान लघु व्य वसायों का भी सक्रिय विस्ताीर करने में सक्षम होंगे। दिनांक 31.03.2019 की स्थिति के अनुसार, 5.99 करोड़ खातों में 3,21,722 करोड़ रूपये (142,345 करोड़ रूपये-शिशु, 104,386 करोड़ रूपये-किशोर और 74,991 करोड़ रूपये-तरुण श्रेणी) संवितरित किए गए हैं।")
                  )))
        ],
      ),
    );
  }
}
