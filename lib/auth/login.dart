import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/enter_otp.dart';


class Login extends StatefulWidget {
  final loadData;
  final built;
  final rebuilt;
  const Login({
    Key? key,
    this.loadData,
    this.built,
    this.rebuilt,
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
          content:  Text('Sending OTP...', style: GoogleFonts.openSans(
            color: Colors.white,
            fontSize: 16,

          )),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.grey,
          shape : RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
        // setState(() {
        //   _isLoading = true;
        // });

        String phoneNumber = '+91 ${this.phoneNumber.trim()}';
        var res = await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential creds) {
            // print('Credentials are $creds');
          },
          verificationFailed: (creds) {
             setState(() {
                _isLoading = false;
              });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${creds.message}',
                  style: TextStyle(color: Colors.white),
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
                }).then((value) => setState((){
                  _isLoading = false;
                
                }));
          },
          codeAutoRetrievalTimeout: (verificationId) {},
        );
        // setState(() {
        //   _isLoading = false;
        // });
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
        // if (controller.hasClients) {
        //   controller
        //       .animateTo(
        //     controller.position.maxScrollExtent,
        //     duration: const Duration(milliseconds: 100),
        //     curve: Curves.easeIn,
        //   )
        //       .then((value) {
        //     controller.animateTo(
        //       controller.position.maxScrollExtent,
        //       duration: const Duration(milliseconds: 100),
        //       curve: Curves.easeIn,
        //     );
        //   });
        // }
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
    // focusNode.addListener(() {
    //   if (focusNode.hasFocus) {
    //     setState(() {
    //       print('Has Focus');
    //       scrollAnimateToEnd(controller);
    //     });
    //   }
    // });
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
      fontSize: width * 0.04,
      fontWeight: FontWeight.w700,
    );
    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        extendBodyBehindAppBar: true,
        extendBody: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(
              top: 100,
              left: 10,
              right: 10,
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/icon.jpg',
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Container(
                  width: width,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    'Connect With Pappu Pehalwan App',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: width * 0.05,
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
                    'पप्पू पहलवान  से संपर्क करें',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(
              height: height * 0.15,
            ),
            Container(
              // width: width * 0.85,
              // height: 60,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),

              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10)),
              child: Form(
                key: formKey,
                child: TextFormField(
                  style: labelStyle,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter your mobile number',
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
            Container(
              // width: width * 0.85,
              height: 60,
              // margin: EdgeInsets.only(
              //   bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              // ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                onTap: _isLoading ? null : () async {
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
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Text(
                        'Login with OTP',
                        style: labelStyle,
                      ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
 
              ],
            ),
          ),
        ));
  }
}
