import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hack_the_tank/firebase_options.dart';
import 'package:hack_the_tank/utils/provider/auth_provider.dart';
import 'package:hack_the_tank/utils/provider/ref_provider.dart';
import 'package:hack_the_tank/view/auth_ui/splash_view/Splash_view.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MultiProvider(
    providers: [
  
      ChangeNotifierProvider(create: (context) => Auth_Provider()),
      ChangeNotifierProvider(create: (context) => RefProvider()),
  
    ],
    child: MyApp(),
  ));}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter hain Demo',
      theme: ThemeData(
     
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splash_view(),
    );
  }
}