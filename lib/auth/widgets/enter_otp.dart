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
      {Key? key,
      this.phoneNumber,
      this.loadData,
      this.verificationId})
      : super(key: key);

  @override
  State<EnterOTP> createState() => _EnterOTPState();
}

class _EnterOTPState extends State<EnterOTP> {
  bool isLoading = false;
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
                MaterialPageRoute(builder: (_) => Body()), (route) => false);
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
    scrollToEnd();
    return Container(
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
              height: 40,
            ),
            Text(
              'Enter OTP',
              style: style.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20,
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
              height: 30,
            ),
            Text(
              '${widget.phoneNumber}',
              textAlign: TextAlign.center,
              style: style.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: width,
              height: 60,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              // margin: EdgeInsets.only(
              //   bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              // ),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                style: style,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'OTP',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.transparent,
                  )),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                onChanged: (val) {
                  setState(() {
                    otp = val;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: isLoading ? null : () {
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
                      color: Colors.grey.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10)),
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text(
                          'Verify OTP',
                          style: style,
                        )),
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
                    onPressed: isLoading ? null : () {
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
          ],
        ),
      ),
    );
  }
}
