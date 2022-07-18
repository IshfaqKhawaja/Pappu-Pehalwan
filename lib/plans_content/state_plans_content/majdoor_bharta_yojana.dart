import 'package:flutter/material.dart';

class MajdoorBhartaYojana extends StatelessWidget {
  const MajdoorBhartaYojana({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "यू.पी मजदूर भत्ता योजना फॉर्म",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Image.asset("assets/images/madjoori_bharta_large.jpeg"),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          ),
          Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child:Text("यू.पी मजदूर भत्ता योजना फॉर्म के द्वारा पटरी दुकानदार/ वेंडर, रिक्शा/ इक्का/ तांगा चालक/ टेम्पो/ ऑटो/ ई रिक्शा चालक, दैनिक दिहाड़ी मजदूर/ मंडियो मे पल्लेदारी करने वाले/ ठेलिया चलाने वाले, अन्य दैनिक कार्य करने वाले व्यक्ति आदि इस श्रेणी/ वर्गों संबद्ध मे संलग्न प्रारूप पर उपलब्ध उकतानुसार वंचित संकलित सूचनाए ऑनलाइन फीड करने के लिए प्रत्येक नगर निगम मे नामित नोडल अधिकारी, नगर पालिका परिसद/ नगर पंचायत मे अधिशासी अधिकारी उत्तरदाई होंगे।\nजिलाधिकारी गरीब लोगों की सूचनाओ को ऑनलाइन फीड करने हेतु अपर जिलाधिकारी स्तर के एक अधिकारी को जिला स्तर पर नोडल अधिकारी तथा तहसील स्तर पर एक अधिकारी को नोडल अधिकारी नामित करेंगे।\nनगर निगम स्तर से नगर आयुक्त एवं जिला स्तर पर अधिकारी द्वारा स्थानीय निकाय क्षेत्र में दैनिक जीवन-यापन करने वाले व्यक्तियों के विषय में सूचना प्रपत्र भरा जाएगा।\nउपयुक्त प्रस्तर-2 मे अंकित श्रेणी के लिए नगरीय स्थानीय निकायो मे पंजीकृत/ सत्यापित पटरी दुकानदार/ वेन्द्र्स की उपलब्ध सूची, रिक्शा चालक/ इक्का, तांगा चालक की नगरीय स्थानीय निकायो मे उपलब्ध पंजीकृत सूची का प्रयोग किया जा सकता है।\nदिहाड़ी मजदूरों के लिए लेबर अड्डो पर एकत्र होने वाले व्यक्तियों से संपर्क करके सूचनाओ का संकलन किया जा सकता है। इसके अतिरिक्त दैनिक रूप से जीवन यापन करने वाले अन्य व्यक्तियों के पंजीकृत संगठनो से भी संपर्क कर वांछित सूचनाए प्राप्त की जा सकती है।\nउपयुक्त वंचित सूचनाएं अपलोड करने के लिए निर्देशक, स्थानीय निकाय द्वारा ऑनलाइन पोर्टल जल्दी जारी कर ऑनलाइन ऑनलाइन पोर्टल पर यूज़र आईडी एवं पासवर्ड जल्दी सभी जनपदों के जिलाधिकारियों को उपलब्ध कराया जायेगा। जो नोडल अधिकारीगण को पासवर्ड उपलब्ध करायेगे। यह कार्यवाही आने वाली 15 दिनों में पूरी की जाएगी।"))))
        ],
      ),
    );
  }
}
