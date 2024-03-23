import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, PhoneAuthProvider;
import 'package:flutter/material.dart';
import 'package:hack_the_tank/constants/button/buttons.dart';
import 'package:hack_the_tank/constants/colors/app_color.dart';
import 'package:hack_the_tank/utils/utils.dart';
import 'package:hack_the_tank/view/home_screen/home.dart';
import 'package:pinput/pinput.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({required this.verificationId, super.key});
  final String verificationId;

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;
  final auth = FirebaseAuth.instance;

  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        title: Center(
          child: Text('Verify Your Code',
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(
                    offset: Offset(3.0, 3.0), // Offset of the shadow
                    blurRadius: 5.0, // Blur radius of the shadow
                    color: Colors.grey.shade400,
                    // Shadow color
                  ),
                ],
              )),
        ),
      ),
      backgroundColor: AppColor.blueColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Pinput(
              closeKeyboardWhenCompleted: true,
              // followingPinTheme: PinTheme(
              //   textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
              // ),
              // focusedPinTheme: PinTheme(
              //   textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
              // ),
              autofocus: true,
              keyboardType: TextInputType.number,
              length: 6,
              controller: _pinPutController,
              focusNode: _pinPutFocusNode,
              onSubmitted: (pin) async {
                if (pin.isEmpty) {
                  Utils.toastMessage('Please enter the verificatioode.');
                  return;
                }

                setState(() {
                  loading = true;
                });

                try {
                  final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: pin,
                  );

                  await auth.signInWithCredential(credential);
                  await Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                    (Route<dynamic> route) => false,
                  );
                } catch (e) {
                  setState(() {
                    loading = false;
                  });

                  Utils.toastMessage(e.toString());
                }
              },
            ),
            const SizedBox(
              height: 80,
            ),
            CustomizeButton(
              color: AppColor.whiteColor,
              text: loading ? 'Verifying...' : 'Log In',
              textcolor: AppColor.blueColor,
              height: 48,
              width: 270,
              fontfamily: 'Quicksand',
              onPressed: () {
                _pinPutFocusNode.requestFocus();
              },
              fontweightt: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}
