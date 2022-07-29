import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  Widget logo(path) {
    return Container(
      child: Image.asset(
        path,
        height: 40,
        width: 40,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var logos = [
      'assets/images/instagram.png',
      'assets/images/facebook.png',
      'assets/images/twitter.png',
      'assets/images/gmail.png',
      'assets/images/whatsapp.jpg',
      'assets/images/call.png',
    ];
    var sizedBox = const SizedBox(height: 20);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              sizedBox,
              Text(
                'हमारे लिए संदेश',
                style: GoogleFonts.openSans(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
              sizedBox,
              Text(
                '''यदि आपके पास हमारे द्वारा प्रदान की जाने वाली सेवाओं के बारे में कोई प्रश्न हैं तो नीचे दिए गए संपर्क नंबर के माध्यम से हमसे संपर्क करें। हम कोशिश करेंगे और 24 घंटे के अंदर सभी प्रश्नों और टिप्पणियों का जवाब दे सके।''',
                // '''If you have any questions about the services we provide simply contact us through below provided options. We try and respond to all queries and comments within 24 hours.''',
                style: GoogleFonts.openSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
              sizedBox,
              sizedBox,
              Text(
                'हमारे साथ जुड़ें',
                style: GoogleFonts.openSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
              sizedBox,

              Text(
                '''हम यहां आपकी सहायता के लिए उपलब्ध हैं। हमसे किसी भी समय सम्पर्क करें।''',
                style: GoogleFonts.openSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
              sizedBox,
              Text(
                '''आप हमें निम्न नंबर पर संपर्क कर सकते हैं''',
                style: GoogleFonts.openSans(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
              sizedBox,
              Center(
                child: InkWell(
                  onTap: () async {
                    const contactNumber = '9876543210';
                    final Uri url = Uri.parse('tel:$contactNumber');
                    if(await canLaunchUrl(url)){
                      await launchUrl(url);
                    }
                  },
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.phone),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("Call us",
                        style: GoogleFonts.openSans(
                          fontSize:20,
                          color: Colors.white
                        ),)
                      ],
                    )
                  ),
                ),
              )
              // Wrap(
              //   alignment:  WrapAlignment.start,
              //   spacing: 10,
              //   runSpacing: 10,
              //   children: logos.map((e) => logo(e)).toList(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
