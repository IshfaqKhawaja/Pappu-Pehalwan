import 'package:flutter/material.dart';

class JeevanJyotiYojana extends StatelessWidget {
  const JeevanJyotiYojana({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'प्रधानमंत्री जीवन ज्योजति बीमा योजना',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Image.asset(
                "assets/images/Pradhan_Mantri_Jeevan_Jyoti_Bima_Yojana.png"),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          ),
          Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                        "पीएमजेजेबीवाई बैंक खाताधारक 18 से 50 वर्ष के आयु समूह के उन सभी व्य क्तियों के लिए उपलब्धव है, जिन्होंेने इस योजना में शामिल होने तथा ऑटो-डेबिट के लिए अपनी सहमति दी हो। 2 लाख रुपए का जीवन कवर 1 जून से 31 मई तक की एक वर्ष की अवमधि के लिए उपलब्धक है और यह नवीकरणीय है। इस योजना के अंतर्गत किसी भी कारण से बीमित व्य क्ति की मृत्युन के मामले में 2 लाख रुपए का जोखिम कवरेज है। इसका प्रीमियम 436 रुपए प्रति वर्ष है, जो अभिदाता द्वारा दिए गए विकल्पव के अनुसार योजना के अंतर्गत प्रत्येयक वार्षिक कवरेज के लिए 31 मई या उससे पूर्व उनके बैंक खाते से एक किश्त में ऑटो-डेबिट किया जाना है। इस योजना का प्रस्तादव जीवन बीमा निगम तथा अन्यि जीवन बीमाकर्ता, जो इस प्रयोजन से अपेक्षित अनुमोदन प्राप्ती करके तथा बैंकों से समझौता करके इन्हीन शर्तों पर इस उत्पा द का प्रस्तानव करने के लिए इच्छुंक हों, द्वारा किया जाता है। 30 अप्रैल, 2022 की स्थिति के अनुसार, बैंकों द्वारा सूचित संचयी समग्र नामांकन के अनुसार पीएमजेजेबीवाई के अंतर्गत कवरेज 12.77 करोड़ है, जो पात्रता के सत्याकपन के अध्यजधीन है। पीएमजेजेबीवाई के अंतर्गत कुल 6,04,889 दावे पंजीकृत किए गए थे जिनमें से 5,76,121 दावों का संवितरण कर दिया गया है।"),
                  )))
        ],
      ),
    );
  }
}
