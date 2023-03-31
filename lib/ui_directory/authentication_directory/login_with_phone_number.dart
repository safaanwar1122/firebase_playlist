import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/ui_directory/authentication_directory/verify_code.dart';
import 'package:untitled/utils_directory/utils.dart';
import 'package:untitled/widgets_directory/round_button.dart';
//https://confluence.atlassian.com/doc/setting-the-java_home-variable-in-windows-8895.html
//https://www.youtube.com/watch?v=wGOTwojezy8
//https://tomgregory.com/java-home-vs-path-environment-variables/
//https://codewithandrea.com/articles/keytool-command-not-found-how-to-fix-windows-macos/
class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  bool loading = false;
  final auth = FirebaseAuth.instance;
  final phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: '+1 234 3456 234'),
            ),
            SizedBox(
              height: 80,
            ),
            RoundButton(
                title: 'Login', loading: loading,
                onTap: () {
                  setState(() {
                    loading=true;
                  });
                  auth.verifyPhoneNumber(
                      phoneNumber: phoneNumberController.text,
                      verificationCompleted: (_) {
                        setState(() {
                          loading=false;
                        });
                      },
                      verificationFailed: (e) {
                        Utils().toastMessage(e.toString());
                      },
                      codeSent: (String verificationId, int? token) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyCodeScreen(
                                      verficationId: verificationId,

                                    ))

                        );
                        setState(() {
                          loading=false;
                        });
                      },
                      codeAutoRetrievalTimeout: (e) {
                        Utils().toastMessage(e.toString());
                        setState(() {
                          loading=false;
                        });
                      });
                })
          ],
        ),
      ),
    );
  }
}
