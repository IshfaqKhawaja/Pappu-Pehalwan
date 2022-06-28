import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jeevansetu/screens/body.dart';

class EnterDetails extends StatefulWidget {
  final userId;
  final phoneNumber;
  final loadData;
  const EnterDetails({
    Key? key,
    this.userId,
    this.phoneNumber,
    this.loadData,
  }) : super(key: key);

  @override
  State<EnterDetails> createState() => _EnterDetailsState();
}

class _EnterDetailsState extends State<EnterDetails> {
  String name = '';
  String email = '';
  String referalCode = '';
  bool isChecked = false;
  bool _isLoading = false;
  bool isNameError = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final style = GoogleFonts.lato(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    );
    final width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(10).copyWith(
        top: 30,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: ',
                style: style,
              ),
              const SizedBox(
                height: 6,
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
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
              ),
              if (isNameError)
                const SizedBox(
                  height: 10,
                ),
              if (isNameError)
                Text(
                  'Please Enter Name',
                  style: GoogleFonts.openSans(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Email: ',
                style: style,
              ),
              const SizedBox(
                height: 6,
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
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Enter Email (Optional)',
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
                      email = val;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Referal Code: ',
                style: style,
              ),
              const SizedBox(
                height: 6,
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
                    hintText: 'Enter Referal Code',
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
                      referalCode = val;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                      value: isChecked,
                      activeColor: Colors.black,
                      checkColor: Colors.redAccent,
                      onChanged: (val) {
                        setState(() {
                          isChecked = val!;
                        });
                      }),
                  Container(
                    width: width * 0.8,
                    child: Text(
                      'I agree to share my name, email, phone number, interests,demographic details, etc. with the Pappu Pehalwan App & integrated third party services for processing, to understand my app usage and receive personalized communication from Pappu Pehalwan. I understand this usage will be based on the Privacy policy.',
                      textAlign: TextAlign.justify,
                      style: style.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: isChecked
                    ? () async {
                        setState(() {
                          _isLoading = true;
                        });
                        await Future.delayed(const Duration(microseconds: 200));
                        try {
                          // bool isValid  = _formKey.currentState!.validate();
                          if (name.isEmpty) {
                            print('Name is $name');
                            // await Future.delayed(const Duration(microseconds: 200));

                            setState(() {
                              _isLoading = false;
                              isNameError = true;
                            });
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //   content: Text('Please Enter Name',
                            //       style: GoogleFonts.openSans(
                            //         color: Colors.white,
                            //       )),
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(10),
                            //   ),
                            //   backgroundColor: Colors.redAccent,
                            // ));
                          } else {
                            // _formKey.currentState!.save();
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.userId)
                                .set({
                              'name': name,
                              'email': email,
                              'referalCode': referalCode,
                              'userId': widget.userId,
                              'isAdmin': false,
                              'phoneNumber': widget.phoneNumber,
                            });
                            await widget.loadData();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (_) => Body()),
                                (route) => false);
                          }
                        } catch (e) {
                          setState(() {
                            _isLoading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(e.toString()),
                          ));
                        }
                      }
                    : null,
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
                        color: isChecked
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Submit',
                            style: style.copyWith(
                              color: Colors.white,
                            ),
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
