import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);
  Widget logo(path) {
    return Container(
      child: Image.asset(path, height: 40,width: 40,fit: BoxFit.cover,),
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
                'Leave Your Message',
                style: GoogleFonts.openSans(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
              sizedBox,
              Text(
                '''If you have any questions about the services we provide simply contact us through below provided options. We try and respond to all queries and comments within 24 hours.''',
                style: GoogleFonts.openSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
              sizedBox,
              sizedBox,
              sizedBox,
              sizedBox,
              Text(
                'Connect With Us On',
                style: GoogleFonts.openSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
              sizedBox,

              Text(
                '''We are here to help you. Feel free to contact us anytime. We are always happy to help you.''',
                style: GoogleFonts.openSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
              sizedBox,
              const SizedBox(
                height: 40,
              ),

              Wrap(
                alignment:  WrapAlignment.start,
                spacing: 10,
                runSpacing: 10,
                children: logos.map((e) => logo(e)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
