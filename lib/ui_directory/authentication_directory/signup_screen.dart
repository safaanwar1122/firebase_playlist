import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/utils_directory/utils.dart';
import 'package:untitled/widgets_directory/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool loading=false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwardController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwardController.dispose();
  }
void signUp()
{
  setState(() {
    loading=true;
  });
  _auth.createUserWithEmailAndPassword(
      email: emailController.text.toString(),
      password: passwardController.text.toString()).then((value) {
    setState(() {
      loading=false;
    });

  }).onError((error, stackTrace) {
    Utils().toastMessage(error.toString());
    setState(() {
      loading=false;
    });
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'email',
                      //helperText: 'enter email@gmail.com ',
                      prefixIcon: Icon(Icons.alternate_email),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: passwardController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'password',
                      prefixIcon: Icon(Icons.lock_open),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter password';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            RoundButton(
              title: 'Sign Up',
              loading: loading,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  signUp();
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account ?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text('Login ')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
