import 'package:flutter/material.dart';

class VishwakarmaYojana extends StatelessWidget {
  const VishwakarmaYojana({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "यू.पी विश्वकर्मा श्रम सम्मान योजना",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Image.asset("assets/images/vishwakarma_samman_large.jpeg"),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          ),
          Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text("उत्तर प्रदेश के मुख्यमंत्री श्री योगी आदित्यनाथ ने सभी परम्परागत कारीगरों के विकास और स्वरोजगार को बढ़ावा देने के लिए विश्वकर्मा श्रम सम्मान योजना 2022 के तहत ऑनलाइन पंजीकरण शुरू कर दिये है। इस विश्वकर्मा श्रम सम्मान योजना 2022 के तहत पारंपरिक कारीगरों व दस्तकारों को अपने हुनर को और ज्यादा निखारने के लिए 6 दिन की फ्री ट्रेनिंग दी जाएगी, जिसका पूरा खर्च राज्य सरकार द्वारा उठाया जाएगा। सफल प्रशिक्षण उपरांत ट्रेड से सम्बंधित ,आधुनिकतम तकनीकी पर आधारित उन्नत किस्म की टूल किट वितरित की जाएगी| इसके साथ ही स्थानीय दस्तकारों तथा पारंपरिक कारीगरों को छोटे उद्योग स्थापित करने के लिए 10 हजार से लेकर 10 लाख रुपये तक की आर्थिक सहायता भी उपलब्ध कराई जाएगी।\n\nइस सरकारी योजना के अंतर्गत राज्य के शहरी व ग्रामीण क्षेत्रों के बढ़ई, दर्जी, टोकरी बुनने वाले, नाई, सुनार, लोहार, कुम्हार, हलवाई, मोची जैसे पारंपरिक कारोबारियों तथा हस्तशिल्प की कला को प्रोत्साहित करने और आगे बढ़ाने के लिए राज्य सरकार ने उत्तर प्रदेश विश्वकर्मा श्रम सम्मान योजना के ऑनलाइन आवेदन शुरू करने का निर्णय लिया है।"))))
        ],
      ),
    );
  }
}
