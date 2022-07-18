import 'package:flutter/material.dart';

class JanDhanSuraksha extends StatelessWidget {
  const JanDhanSuraksha({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'जन-धन से जन सुरक्षा',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Image.asset("assets/images/jan_dhan_suraksha.jpg"),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          ),
          Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                        "सभी भारतियों विशेष रूप से गरीबों तथा वंचितों के लिए सर्व-व्या्पी सामाजिक सुरक्षा प्रणाली सृजित करने के लिए माननीय प्रधानमंत्री ने 9 मई, 2015 को बीमा तथा पेंशन क्षेत्रों में तीन सामाजिक सुरक्षा योजनाओं का शुभारंभ किया था।"))),
          )
        ],
      ),
    );
  }
}
