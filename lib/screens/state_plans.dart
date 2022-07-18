import 'package:flutter/material.dart';
import '../plans_content/state_plans_content/digrit_kit_yojana.dart';
import '../plans_content/state_plans_content/kanya_sumangala_yojana.dart';
import '../plans_content/state_plans_content/krashak_yojana.dart';
import '../plans_content/state_plans_content/kukut_palan_yojana.dart';
import '../plans_content/state_plans_content/majdoor_bharta_yojana.dart';
import '../plans_content/state_plans_content/vidhwa_pention%20yojana.dart';
import '../plans_content/state_plans_content/viklang_pention_yojana.dart';
import '../plans_content/state_plans_content/viklang_sadhi_yojana.dart';
import '../plans_content/state_plans_content/vishwakarma_yojana.dart';
import '../plans_content/state_plans_content/vradh_pention_yojana.dart';
import '../constant.dart';
class StatesPlans extends StatefulWidget {
  const StatesPlans({Key? key}) : super(key: key);

  @override
  State<StatesPlans> createState() => _StatesPlansState();
}

class _StatesPlansState extends State<StatesPlans> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        InkWell(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>const ViklangPentionYojana()));
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 65,
            color: const Color(0xffD9D9D9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/viklang_pention.png'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("यू.पी विकलांग (दिव्यांग) पेंशन योजना"),
                    Row(
                      children: [
                        Text("यूपी विकलांग पेंशन योजना का लाभ लेने के लिए.....",style: plansContentTextStyle,),
                        const SizedBox(
                          width: 4,
                        ),
                        Row(
                          children: const [
                            Icon(Icons.arrow_forward_ios,size: 10,color: Color(0xff146AA7),),
                            Icon(Icons.arrow_forward_ios,size: 10,color: Color(0xff146AA7))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        InkWell(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=> const KrashakYojana()));
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 65,
            color: const Color(0xffD9D9D9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/majdoori_durghatna.png'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("मुख्यमंत्री कृषक दुर्घटना कल्याण योजना"),
                    Row(
                      children: [
                        Text("मुख्यमंत्री कृषक दुर्घटना कल्याण योजना के अंतर्गत.....",style: plansContentTextStyle,),
                        const SizedBox(
                          width: 4,
                        ),
                        Row(
                          children: const [
                            Icon(Icons.arrow_forward_ios,size: 10,color: Color(0xff146AA7),),
                            Icon(Icons.arrow_forward_ios,size: 10,color: Color(0xff146AA7))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        InkWell(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=> const VradhaPentionYojana()));
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 65,
            color: const Color(0xffD9D9D9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/vradha_pention.png'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("उत्तर प्रदेश वृद्धा पेंशन योजना"),
                    Row(
                      children: [
                        Text("उत्तर प्रदेश वृद्धा पेंशन योजना 2021 के लिए ऑनलाइन.....",style: plansContentTextStyle,),
                        const SizedBox(
                          width: 4,
                        ),
                        Row(
                          children: const [
                            Icon(Icons.arrow_forward_ios,size: 10,color: Color(0xff146AA7),),
                            Icon(Icons.arrow_forward_ios,size: 10,color: Color(0xff146AA7))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        InkWell(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=> const VishwakarmaYojana()));
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 65,
            color: const Color(0xffD9D9D9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/vishwakarma_samman.png'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("उत्तर प्रदेश विश्वकर्मा श्रम सम्मान योजना"),
                    Row(
                      children: [
                        Text("उत्तर प्रदेश के मुख्यमंत्री श्री योगी आदित्यनाथ ने.....",style: plansContentTextStyle,),
                        const SizedBox(
                          width: 4,
                        ),
                        Row(
                          children: const [
                            Icon(Icons.arrow_forward_ios,size: 10,color: Color(0xff146AA7),),
                            Icon(Icons.arrow_forward_ios,size: 10,color: Color(0xff146AA7))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        InkWell(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>const KukutPalanYojana()));
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 65,
            color: const Color(0xffD9D9D9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/kukut_palan.png'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("यू.पी कुक्कुट पालन कर्ज योजना"),
                    Row(
                      children: [
                        Text("उत्तर प्रदेश सरकार ने राज्य में लोगों को स्वरोजगार स्थापित...",style: plansContentTextStyle,),
                        const SizedBox(
                          width: 4,
                        ),
                        Row(
                          children: const [
                            Icon(Icons.arrow_forward_ios,size: 10,color: Color(0xff146AA7),),
                            Icon(Icons.arrow_forward_ios,size: 10,color: Color(0xff146AA7))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        InkWell(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=> const MajdoorBhartaYojana()));
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 65,
            color: const Color(0xffD9D9D9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/madjoori_bharta.png'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("यू.पी मजदूर भत्ता योजना फॉर्म"),
                    Row(
                      children: [
                        Text("यू.पी मजदूर भत्ता योजना फॉर्म के द्वारा पटरी दुकानदार.....",style: plansContentTextStyle,),
                        const SizedBox(
                          width: 4,
                        ),
                        Row(
                          children: const [
                            Icon(Icons.arrow_forward_ios,size: 10,color: Color(0xff146AA7),),
                            Icon(Icons.arrow_forward_ios,size: 10,color: Color(0xff146AA7))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        InkWell(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>const KanyaSumangalaYojana()));
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 65,
            color: const Color(0xffD9D9D9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/kanya_sumangala.png'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("यू.पी मुख्यमंत्री कन्या सुमंगला योजना"),
                    Row(
                      children: [
                        Text("यू.पी मुख्यमंत्री कन्या सुमंगला योजनाका उद्देश्य राज्य के.....",style: plansContentTextStyle,),
                        const SizedBox(
                          width: 4,
                        ),
                        Row(
                          children: const [
                            Icon(Icons.arrow_forward_ios,size: 10,color: Color(0xff146AA7),),
                            Icon(Icons.arrow_forward_ios,size: 10,color: Color(0xff146AA7))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        InkWell(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>const ViklangSadhiYojana()));
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 65,
            color: const Color(0xffD9D9D9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/viklang_sadhi.png'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("यू.पी विकलांग शादी अनुदान योजना"),
                    Row(
                      children: [
                        Text("दिव्यांग शादी विवाह प्रोत्साहन योजना को प्रदेश के सहयोग...",style: plansContentTextStyle,),
                        const SizedBox(
                          width: 4,
                        ),
                        Row(
                          children: const [
                            Icon(Icons.arrow_forward_ios,size: 10,color: Color(0xff146AA7),),
                            Icon(Icons.arrow_forward_ios,size: 10,color: Color(0xff146AA7))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        InkWell(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>const DigritKitYojana()));
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 65,
            color: const Color(0xffD9D9D9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/dignity_kit.png'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("यू.पी डिग्निटी किट योजना"),
                    Row(
                      children: [
                        Text("यूपी सरकार, राज्य आपदा प्रबंधन प्राधिकरण के सहयोग.....",style: plansContentTextStyle,),
                        const SizedBox(
                          width: 4,
                        ),
                        Row(
                          children: const [
                            Icon(Icons.arrow_forward_ios,size: 10,color: Color(0xff146AA7),),
                            Icon(Icons.arrow_forward_ios,size: 10,color: Color(0xff146AA7))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        InkWell(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>const VidhwaPentionYojana()));
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 65,
            color: const Color(0xffD9D9D9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/vidwa_pention.png'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("यू.पी विधवा पेंशन योजना"),
                    Row(
                      children: [
                        Text("उत्तर प्रदेश सरकार ने यह योजना निराश्रित विधवा महिला...",style: plansContentTextStyle,),
                        const SizedBox(
                          width: 4,
                        ),
                        Row(
                          children: const [
                            Icon(Icons.arrow_forward_ios,size: 10,color: Color(0xff146AA7),),
                            Icon(Icons.arrow_forward_ios,size: 10,color: Color(0xff146AA7))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
