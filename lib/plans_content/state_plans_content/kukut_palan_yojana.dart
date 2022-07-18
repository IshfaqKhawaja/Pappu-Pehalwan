import 'package:flutter/material.dart';

class KukutPalanYojana extends StatelessWidget {
  const KukutPalanYojana({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "यू.पी कुक्कुट पालन कर्ज योजना",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Image.asset("assets/images/kukut_palan_large.jpeg"),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          ),
          Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text("उत्तर प्रदेश सरकार ने राज्य में लोगों को स्वरोजगार स्थापित करने के लिए कुक्कुट पालन कर्ज योजना शुरू की है। लोग कुक्कुट पालन योजना के तहत आवेदन करके (Poultry Farming Scheme Registration in Uttar pradesh) मुर्गी फार्म लगा सकते हैं जिससे इस क्षेत्र में रोजगार के अवसर बढ़ेंगे। योगी सरकार जैसे पशुपालन के लिए लोन उपलब्ध कराती है उसी तरह कुक्कुट पालन कर्ज योजना (Poultry Farming Subsidized Bank Loan) के तहत लोगों को अपना स्वयं का व्यवसाय लगाने में भी बैंक से सब्सिडी पर लोन दिया जाएगा जिसके लिए पंजीकरण करने की जानकारी नीचे दी गई है। योगी सरकार ने कुक्कुट पालन योजना के अंतर्गत मुर्गी पालन व्यवसाय को बढ़ावा देने के लिए आकर्षक एवं व्यवहारिक कुक्कुट विकास नीति जारी की है। \n\nकुक्कुट पालन विकास नीति (Uttar Pradesh Poultry Development Project) का उद्देश्य छोटे मुर्गी पालकों को इससे फायदा पहुंचाना है। जिसके लिए प्रदेश की सरकार उद्यमों को बढ़ावा देने के लिए विभिन्न प्रकार का सहयोग दे रही है। किसान भाई या फिर कोई भी युवा कुक्कुट पालन योजना से अपनी स्थायी आय सुनिश्चित कर सकता है। इसके साथ ही खेती के साथ-साथ पशुपालन, मुर्गी पालन कर किसान भाई भी अपनी आय में वृद्धि कर सकते हैं। 2022 तक किसानों की आय दोगुनी करने वाले प्रधानमंत्री मोदी के सपने को पूरा करने में यह एक बहुत बड़ा कदम होगा।")))
          )],
      ),
    );
  }
}
