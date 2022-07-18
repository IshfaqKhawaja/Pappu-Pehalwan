import 'package:flutter/material.dart';

class KrashakYojana extends StatelessWidget {
  const KrashakYojana({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "मुख्यमंत्री कृषक दुर्घटना कल्याण योजना",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Image.asset("assets/images/majdoori_durghatna_large.jpeg"),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          ),
          Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text("मुख्यमंत्री कृषक दुर्घटना कल्याण योजना के अंतर्गत जिला अधिकारी जगजीत कौर ने 18 में से 4 दावों को स्वीकार कर लिया है, 6 दावों को निरस्त कर दिया है तथा 8 दावों को अपूर्ण होने के कारण पेंडिंग कर दिया है। वह सभी लाभार्थी जो इस योजना के पात्र हैं उन्हें इस योजना का लाभ पहुंचाया जाएगा। इस योजना का लाभ उठाने के लिए किसान भाइयो को राज्य का स्थाई निवासी होना अनिवार्य है और उनकी मुख्य इनकम खेती से आनी चाहिए। इसके अलावा किसान की आयु 18 से 70 वर्ष के बीच होनी चाहिए।\n\nयदि किसान के पास अपनी जमीन नहीं है और वह किसी और की जमीन पर खेती करता है और उसकी किसी दुर्घटना के कारण मृत्यु हो जाती है या फिर वह किसी दुर्घटना के कारण दिव्यांग हो जाता है तो वह भी Mukhyamantri Krishak Durghatna Kalyan Yojana का लाभ उठा सकता है। जिलाधिकारी यह भी आश्वासन दिया है कि पेंडिंग दावों को किसी भी स्थिति में लंबित नहीं रखा जाएगा।"))))
        ],
      ),
    );
  }
}
