import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hack_the_tank/view/auth_ui/create_account.dart';
import 'package:hack_the_tank/view/home_screen/home.dart';
import 'package:hack_the_tank/view/home_screen/invite_friend.dart';

// ignore: public_member_api_docs
class SplashServices {
  void isLogin(BuildContext context) async{
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
     await Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => InviteFriendScreen()),
        ),
      );
    } else {
       await Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const CreateAccountPage()),
        ),
      );
    }
  }
}
