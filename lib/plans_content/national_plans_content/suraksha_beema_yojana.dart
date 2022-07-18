import 'package:flutter/material.dart';

class SurakshaBeemaYojana extends StatelessWidget {
  const SurakshaBeemaYojana({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'प्रधानमंत्री सुरक्षा बीमा योजना',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Image.asset("assets/images/PM_suraksha_beema_yojana.jpg"),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          ),
          Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                        "यह योजना एक बैंक खाता रखने वाले 18 से 70 वर्ष की आयु वर्ग के उन लोगों के लिए जो 1 जून से 31 मई की कवरेज अवधि के लिए योजना में शामिल होने/स्वेत: आहरण समर्थन को 31 मई या उससे पहले अपनी सहमति प्रदान करते हैं, वार्षिक नवीनीकरण आधार पर उपलब्ध है। आधार, बैंक खातों के लिए प्राथमिक केवाईसी होगा। योजना के अंतर्गत दुर्घटना मृत्युध होने पर और पूर्ण विकलांगता के लिए जोखिम कवरेज 2 लाख रूपये तथा आंशिक विकलांगता पर जोखिम कवरेज 1 लाख रूपये है। खाताधारक के बैंक खाते से ‘स्वित: आहरण’ सुविधा के जरिए एक किस्तक में 20 रुपये की वार्षिक प्रीमियम की कटौती की जानी है। यह योजना सार्वजनिक क्षेत्र की साधारण बीमा कंपनियों या किसी अन्यट साधारण बीमा कंपनी द्वारा जो इस उद्देश्य के लिए बैंकों के साथ इन्हींक शर्तों पर आवश्यौक अनुमोदन तथा सहमति से उत्पााद की पेशकश करने को इच्छुैक है, पेशकश की जा रही है। 30 अप्रैल, 2022 की स्थिति के अनुसार बैंकों द्वारा दी गई सूचना के अनुसार पीएमएसबीवाई के अंतर्गत पात्रता के सत्यापपन के अध्यिधीन संचयी सकल नामांकन 28.37 करोड़ रूपये से अधिक है। पीएमएसबीवाई के अंतर्गत कुल 1,22,082 दावों में से 97,227 दावों का संवितरण किया गया है"),
                  )))
        ],
      ),
    );
  }
}
