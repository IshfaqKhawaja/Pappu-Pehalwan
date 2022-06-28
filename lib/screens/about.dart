import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const  Text('About'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0).copyWith(top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text(
                          'पप्पू पहलवान ',
                          style: GoogleFonts.openSans(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xffd4580e),
                          ),
                        ),
                        Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing.',
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.openSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 12,
                        // ),
                        // Text(
                        //   'सन 1984 में राजनीति में कदम रखने के बाद वर्ष 2002 में (घिरोर, मैनपुरी) से विधायक चुने गए। वर्ष 2003 में उत्तर प्रदेश सरकार में राज्य मंत्री ( चिकित्सा एवं स्वास्थ्य) नियुक्त हुए। राज्य मंत्री के रूप में कार्यकाल 2006 तक रहा। वर्ष 2007-2012 तक राज्य मंत्री स्वतंत्र प्रभार के दायित्व का निर्वहन किया। इनकी छवि प्रखर वक्ता एवं कुशल राजनेता के रूप में विकसित रही है।',
                        //   style: GoogleFonts.openSans(
                        //     fontSize: 10,
                        //     fontWeight: FontWeight.w600,
                        //     color: Colors.black.withOpacity(0.7),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/about.jpg',
                      height: height * 0.38,
                      fit: BoxFit.fitHeight,
                    ),
                  )
                ],
              ),
              // const SizedBox(
              //   height: 10,
              // ), 
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'प्रारंभिक जीवन',
                    style: GoogleFonts.openSans(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.9),
                    ),
                  ),
                  Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                     textAlign: TextAlign.justify,
                    style: GoogleFonts.openSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'राजनीतिक जीवन',
                    style: GoogleFonts.openSans(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.9),
                    ),
                  ),
                  Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.openSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
