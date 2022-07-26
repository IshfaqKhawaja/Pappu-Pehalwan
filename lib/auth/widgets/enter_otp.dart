import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../screens/body.dart';
import 'enter_details.dart';

class EnterOTP extends StatefulWidget {
  final phoneNumber;
  final verificationId;
  final loadData;

  const EnterOTP(
      {Key? key, this.phoneNumber, this.loadData, this.verificationId})
      : super(key: key);

  @override
  State<EnterOTP> createState() => _EnterOTPState();
}

class _EnterOTPState extends State<EnterOTP> {
  bool isLoading = false;
  List<String> otpFields = ['','','','','',''];
  String otp = '';
  final controller = ScrollController();

  void scrollToEnd() {
    if (controller.hasClients) {
      controller.jumpTo(controller.position.maxScrollExtent);
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void sendCodeToFirebase({String? otp, context}) async {
    FocusScope.of(context).unfocus();
    if (widget.verificationId != '' && otp != '') {
      setState(() {
        isLoading = true;
      });
      var credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp!,
      );
      try {
        final userCreds =
            await FirebaseAuth.instance.signInWithCredential(credential);
        // print(userCreds.user!.uid);
        if (userCreds.user != null) {
          final userId = userCreds.user!.uid;
          final user = await FirebaseFirestore.instance
              .collection('users')
              .where('userId', isEqualTo: userId)
              .get();
          if (user.docs.isNotEmpty) {
            await widget.loadData();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const Body()), (route) => false);
          } else {
            Navigator.of(context).pop();
            showModalBottomSheet(
                context: context,
                isDismissible: false,
                isScrollControlled: true,
                builder: (ctx) {
                  return EnterDetails(
                    userId: userId,
                    phoneNumber: widget.phoneNumber,
                    loadData: widget.loadData,
                  );
                });
          }
        }
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        showDialog(
          context: context,
          builder: (ctx) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                e.toString(),
              ),
            ),
          ),
        );
        setState(() {
          isLoading = false;
        });
        print('Error is : ');
        print(e);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Invalid Credentials'),
        duration: const Duration(seconds: 2),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final style = GoogleFonts.lato(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: Colors.black,
    );
    final style2 = GoogleFonts.lato(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: const Color(0xffC4C4C4),
    );
    scrollToEnd();
    return Container(
      color: const Color(0xffEDDFD4),
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.64,
      padding: const EdgeInsets.all(10).copyWith(
        top: 30,
      ),
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            Text(
              'Welcome to Pappu Pehalwan App',
              style: style,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Enter OTP',
              style: style.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Please enter One Time Password (OTP) sent to your Mobile Number for verification',
              textAlign: TextAlign.center,
              style: style.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${widget.phoneNumber}',
              textAlign: TextAlign.center,
              style: style.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            // const SizedBox(
              //height: 20,
            //),
            Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "OTP",
                      style: style,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _otpTextField(0,true,false),
                        _otpTextField(1,false,false),
                        _otpTextField(2,false,false),
                        _otpTextField(3,false,false),
                        _otpTextField(4,false,false),
                        _otpTextField(5,false,true),
                      ],
                    )
                  ],
                )
                ),
            const SizedBox(
              height: 13,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Didn\'t receive OTP?',
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            Navigator.of(context).pop();
                          },
                    child: Text('Resend',
                        style: style.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.green,
                        ))),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: isLoading
                  ? null
                  : () {
                      FocusScope.of(context).unfocus();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'OTP sent to your Mobile Number',
                            style: style.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                      otp = otpFields.join('');
                      // print(otp);
                      sendCodeToFirebase(otp: otp, context: context);
                    },
              child: Container(
                  width: width,
                  height: 60,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 15,
                  ),
                  decoration: BoxDecoration(
                      color: const Color(0xff56514D),
                      borderRadius: BorderRadius.circular(10)),
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text(
                          'Submit',
                          style: style2,
                        )),
            ),
          ],
        ),
      ),
    );
  }

  //OTP TextField
  _otpTextField(int index,bool first, bool last) {
    return Container(
      height: 45,
      width: 43,
      child: AspectRatio(
        aspectRatio: 0.7,
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.number,
          onChanged: (val) {
            if(val.length==1){
              FocusScope.of(context).nextFocus();
              otpFields[index] = val;
            }
            if(val.isEmpty){
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textInputAction: TextInputAction.next,
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
          maxLength: 1,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 14.5),
            fillColor: const Color(0xffC4C4C4),
            filled: true,
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2,color: Colors.black.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Color(0xff56514D)),
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    );
  }
}
