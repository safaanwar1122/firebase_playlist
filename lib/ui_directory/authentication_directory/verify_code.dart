import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/ui_directory/posts_directory/post_screen.dart';

import '../../utils_directory/utils.dart';
import '../../widgets_directory/round_button.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verficationId;
   VerifyCodeScreen({Key? key, required this.verficationId}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {

  bool loading = false;
  final auth = FirebaseAuth.instance;
  final verificationCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            TextFormField(
              controller: verificationCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: '6 digit code'),
            ),
            SizedBox(
              height: 80,
            ),
            RoundButton(
                title: 'verify', loading: loading,
                onTap: () async{
                  setState(() {
                    loading=true;
                  });
                  final credital=PhoneAuthProvider.credential(
                      verificationId: widget.verficationId,
                      smsCode: verificationCodeController.text.toString());

                  try{
                    await auth.signInWithCredential(credital);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PostsScreen()));
                  }
                  catch(e){
                    setState(() {
                      loading=false;
                    });
                    Utils().toastMessage(e.toString());
                  }
                }),
          ],
        ),
      ),
    );
  }
  }

