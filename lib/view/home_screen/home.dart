import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hack_the_tank/constants/colors/app_color.dart';
import 'package:hack_the_tank/view/auth_ui/create_account.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   Future<void> _signOut(BuildContext context) async {
    try {
      // Create a Completer to handle the result of the dialog
      Completer<bool> completer = Completer<bool>();

      // Show a confirmation dialog
      Dialogs.bottomMaterialDialog(
        msg: 'Are you sure you want to log out? You can\'t undo this action.',
        msgStyle: TextStyle(
            color: AppColor.blueColor,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w700,
            fontSize: 15),
        title: 'Logout',
        titleStyle: TextStyle(
                              color:AppColor.redColor,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w700,
                              fontSize: 19),
        context: context,
        actions: [
          IconsOutlineButton(
            onPressed: () {
              completer.complete(
                  false); // Complete with 'false' when Cancel is pressed
              Navigator.of(context).pop();
            },
            text: 'Cancel',
            iconData: Icons.cancel_outlined,
            textStyle: TextStyle(color: Colors.grey),
            iconColor: Colors.grey,
          ),
          IconsButton(
            onPressed: () async {
              completer.complete(
                  true); // Complete with 'true' when Logout is pressed
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateAccountPage()),
                (route) => false,
              );
            },
            text: 'Logout',
            iconData: Icons.exit_to_app,
            color: Colors.blue,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ],
      );

      // Wait for the user's decision
      bool result = await completer.future;

      // If the user confirms the logout, result will be true
      if (result == true) {
        // Perform the logout
        await FirebaseAuth.instance.signOut();

        // Navigate to the CreateAccountPage and remove all previous routes
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const CreateAccountPage()),
          (route) => false,
        );
      }
    } catch (error) {
      print('Error signing out: $error');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          Row(
            children: [Text("it's Home")],
          ),
            const Divider(color: Colors.black),
                      ListTile(
                          title: Text(
                            'Logout',
                            style: TextStyle(
                                color: 
                                     Colors.black,
                                    
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w700,
                                fontSize: 19),
                          ),
                          onTap: () {
                            _signOut(context);
                          }),
        ],
      ),
    );
  }
}
