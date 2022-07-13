import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/enter_otp.dart';

class Login extends StatefulWidget {
  final loadData;

  const Login({
    Key? key,
    this.loadData,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String phoneNumber = '';
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String otp = '';
  String verificationId = '';
  double width = 0.0;
  final controller = ScrollController();
  final focusNode = FocusNode();

  void phoneVerification() async {
    FocusScope.of(context).unfocus();
    if (phoneNumber != '' && phoneNumber.length == 10) {
      try {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Sending OTP...',
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 16,
              )),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

        String phoneNumber = '+91 ${this.phoneNumber.trim()}';
        var res = await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential creds) {
            // print('Credentials are $creds');
          },
          verificationFailed: (creds) {
            print(creds);
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${creds.message}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          },
          codeSent: (verificationId, resendingToken) {
            // print('Verification id is $verificationId');
            setState(() {
              this.verificationId = verificationId;
            });
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            showModalBottomSheet(
                context: context,
                isDismissible: false,
                isScrollControlled: true,
                builder: (ctx) {
                  return EnterOTP(
                    phoneNumber: phoneNumber,
                    loadData: widget.loadData,
                    verificationId: verificationId,
                  );
                }).then((value) => setState(() {
                  _isLoading = false;
                }));
          },
          codeAutoRetrievalTimeout: (verificationId) {},
        );
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
          duration: const Duration(seconds: 2),
        ));
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text('Phone Number should be 10 digits and should not be empty'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  void scrollAnimateToEnd(ScrollController controller) {
    Future.delayed(const Duration(milliseconds: 100)).then((_) {
      try {
        controller.jumpTo(controller.position.maxScrollExtent);
      } catch (e) {
        print('error on scroll $e');
      }
    });
  }

  bool isKeyBoardOpen = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final labelStyle = GoogleFonts.openSans(
      color: Colors.black,
      fontSize: width * 0.05,
      fontWeight: FontWeight.w700,
    );
    final labelStyle2 = GoogleFonts.openSans(
      color: Color(0xffC4C4C4),
      fontSize: width * 0.05,
      fontWeight: FontWeight.w700,
    );
    // print(MediaQuery.of(context).viewInsets.bottom);
    scrollAnimateToEnd(controller);

    return Scaffold(
      backgroundColor: const Color(0xffEDDFD4),
      extendBodyBehindAppBar: true,
      extendBody: false,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(
            top: 10,
          ),
          controller: controller,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/swachbharat.png"),
                Image.asset("assets/images/partyLogo.png")
              ],
            ),
            SizedBox(
              height: height * 0.12,
            ),
            CircleAvatar(
              radius: width * 0.3,
              backgroundImage: Image.asset(
                'assets/images/icon.jpg',
                fit: BoxFit.cover,
              ).image,
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              width: width,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'पप्पू पहलवान',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  color: Color(0xff4D4D51),
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Container(
              width: width,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Text(
                ' महानगर महामंत्री गाज़ियाबाद',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  color: Color(0xffF17840),
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Container(
              width: width,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Text(
                'भारतीय जनता पार्टी',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  color: Color(0xff285438),
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Container(
              // width: width * 0.85,
              // height: 60,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black.withOpacity(0.4))),
              child: Form(
                key: formKey,
                child: TextFormField(
                  style: labelStyle,
                  focusNode: focusNode,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'अपना मोबाइल नंबर दर्ज करें',
                    hintStyle: labelStyle.copyWith(
                      fontSize: width * 0.04,
                    ),
                    prefix: Text('+91 ', style: labelStyle),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.transparent,
                    )),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      phoneNumber = val;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: _isLoading
                  ? null
                  : () async {
                      setState(() {
                        _isLoading = true;
                      });
                      await Future.delayed(const Duration(milliseconds: 500));
                      try {
                        phoneVerification();
                      } catch (e) {
                        setState(() {
                          _isLoading = false;
                        });
                        print(e);
                      }
                    },
              child: Container(
                // width: width * 0.85,
                height: 60,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                    color: Color(0xff56514D),
                    borderRadius: BorderRadius.circular(10)),
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Text(
                        'Login with OTP',
                        style: labelStyle2,
                      ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
