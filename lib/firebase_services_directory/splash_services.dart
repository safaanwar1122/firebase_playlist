

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/ui_directory/authentication_directory/login_screen.dart';
import 'package:untitled/ui_directory/firestore_directory/firestore_list_screen.dart';
import 'package:untitled/ui_directory/posts_directory/post_screen.dart';
import 'package:untitled/ui_directory/upload_image.dart';

class SplashServices{
  void isLogin(BuildContext context ){
    final auth = FirebaseAuth.instance;
    final user= auth.currentUser;
    if(user!=null)
      {
        Timer(const Duration(seconds: 3),()=>
            Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadImageScreen())),
        );
      }
    else {
      Timer(const Duration(seconds: 3),()=>
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()))
      );
    }

  }
}