import 'package:flutter/material.dart';
import 'package:pappupehalwan/plans_content/national_plans_content/atal_penstion_yojana.dart';
import 'package:pappupehalwan/plans_content/national_plans_content/jan_dhan_suraksha.dart';
import 'package:pappupehalwan/plans_content/national_plans_content/jan_dhan_yojana.dart';
import 'package:pappupehalwan/plans_content/national_plans_content/jeevan_jyoti_yojana.dart';
import 'package:pappupehalwan/plans_content/national_plans_content/pm_mudara_yojana.dart';
import 'package:pappupehalwan/plans_content/national_plans_content/stand_up_India.dart';
import 'package:pappupehalwan/plans_content/national_plans_content/suraksha_beema_yojana.dart';
import 'package:pappupehalwan/plans_content/national_plans_content/vaya_vandana_yojana.dart';
import '../constant.dart';
class NationalPlans extends StatefulWidget {
  const NationalPlans({Key? key}) : super(key: key);

  @override
  State<NationalPlans> createState() => _NationalPlansState();
}

class _NationalPlansState extends State<NationalPlans> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const JanDhanYojana()));
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 65,
            color: const Color(0xffD9D9D9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/yojna1.png'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("प्रधानमंत्री जन-धन योजना"),
                    Row(
                      children: [
                        Text("माननीय प्रधान मंत्री ने प्रत्येक परिवार के लिए कम से.....",style: plansContentTextStyle,),
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const JanDhanSuraksha()));
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 65,
            color: const Color(0xffD9D9D9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/yojna2.png'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("जन-धन से जन सुरक्षा"),
                    Row(
                      children: [
                        Text("सभी भारतियों विशेष रूप से गरीबों तथा वंचितों के लिए.....",style: plansContentTextStyle,),
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const JeevanJyotiYojana()));
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 65,
            color: const Color(0xffD9D9D9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/yojna3.png'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("प्रधानमंत्री जीवन ज्योजति बीमा योजना"),
                    Row(
                      children: [
                        Text("पीएमजेजेबीवाई बैंक खाताधारक 18 से 50 वर्ष के आयु.....",style: plansContentTextStyle,),
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const SurakshaBeemaYojana()));
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 65,
            color: const Color(0xffD9D9D9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/yojna4.png'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("प्रधानमंत्री सुरक्षा बीमा योजना"),
                    Row(
                      children: [
                        Text("यह योजना एक बैंक खाता रखने वाले 18 से 70.....",style: plansContentTextStyle,),
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const AtalPentionYojana()));
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 65,
            color: const Color(0xffD9D9D9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/yojna5.png'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("अटल पेंशन योजना"),
                    Row(
                      children: [
                        Text("अटल पेंशन योजना प्रधानमंत्री द्वारा 9 मई,2015 को.....",style: plansContentTextStyle,),
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const PmMudaraYojana()));
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 65,
            color: const Color(0xffD9D9D9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/yojna6.png'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("प्रधानमंत्री मुद्रा योजना"),
                    Row(
                      children: [
                        Text("योजना 8 अप्रैल, 2015 को आरंभ की गई थी.....",style: plansContentTextStyle,),
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const StandUpIndia()));
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 65,
            color: const Color(0xffD9D9D9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/yojna7.png'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("स्टैंंड अप इंडिया योजना"),
                    Row(
                      children: [
                        Text("भारत सरकार ने 5 अप्रैल 2016 को स्टैंड अप इंडिया.....",style: plansContentTextStyle,),
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const VayaVandanaYojana()));
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 65,
            color: const Color(0xffD9D9D9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/yojna8.png'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("प्रधानमंत्री वय वन्दना योजना"),
                    Row(
                      children: [
                        Text("प्रधानमंत्री वय वंदना योजना का शुभारंभ अनिश्चित.....",style: plansContentTextStyle,),
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
