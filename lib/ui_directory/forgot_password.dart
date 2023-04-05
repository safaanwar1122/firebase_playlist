import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/utils_directory/utils.dart';
import 'package:untitled/widgets_directory/round_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController=TextEditingController();
  final auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot password screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'email',

              ),
            ),
            SizedBox(
              height: 40,
            ),
            RoundButton(title: 'Forget', onTap: (){
              auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value) {
                Utils().toastMessage('We have sent you email t recover password, please check email');
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
            })

          ],
        ),
      ),
    );
  }
}
