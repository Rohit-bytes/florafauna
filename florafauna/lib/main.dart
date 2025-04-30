import 'package:florafauna/providers/profile.dart';
import 'package:florafauna/view/homepage.dart';
import 'package:florafauna/view/landingpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool hasSeenGetStarted = prefs.getBool('hasSeenGetStarted') ?? false;


  runApp(
    MultiProvider(providers: [ChangeNotifierProvider(create: (_)=>Profileprovider())],child:  MyApp(hasSeenGetStarted: hasSeenGetStarted)),);
   
}

class MyApp extends StatelessWidget {
  final bool hasSeenGetStarted;
  
  const MyApp({super.key, required this.hasSeenGetStarted});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: hasSeenGetStarted ? const Homepage() : const Landingpage(),
    );
  }
}
