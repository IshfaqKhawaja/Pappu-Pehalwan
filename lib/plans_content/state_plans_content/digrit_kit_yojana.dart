import 'package:flutter/material.dart';

class DigritKitYojana extends StatelessWidget {
  const DigritKitYojana({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'यू.पी डिग्निटी किट योजना',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Image.asset("assets/images/dignity_kit_large.jpeg"),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          ),
          Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text("यूपी सरकार, राज्य आपदा प्रबंधन प्राधिकरण के सहयोग से, राज्य के 25 जिलों में अपनी आपदा मित्र और आपदा सखी योजनाओं का विस्तार करने के लिए पूरी तरह तैयार है। “आपदा मित्र” और “आपदा सखी” को किसी भी आपदा से निपटने के लिए बाढ़ सुरक्षा उपकरण, सुरक्षा किट और प्रशिक्षण प्रदान किया जाएगा।\n\nयूपी डिग्निटी किट योजना के तहत लोगों को प्राकृतिक आपदाओं जैसे बारिश, बादल फटना, ओलावृष्टि आदि से निपटने के लिए सहायता प्रदान की जाएगी। उल्लेखनीय है कि पिछले पांच वर्षों में योगी सरकार के प्रयासों से राज्य स्तरीय आपातकाल राहत आयुक्त कार्यालय की देखरेख में केंद्र एवं राहत हेल्पलाइन 1070 की स्थापना की गई। इसके अलावा, राहत हेल्पलाइन को 24 घंटे चालू रखने के लिए, राज्य में 15 कॉल सेंटर भी चल रहे हैं।"))))
        ],
      ),
    );
  }
}
