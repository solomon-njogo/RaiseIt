import 'package:flutter/material.dart';
//import 'package:raiseit/views/home_screen/home_screen.dart';
import 'package:raiseit/views/auth_screens/login_screen.dart';
//import 'package:raiseit/views/auth_screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    );
    
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
  //routes: {
    //'/login': (context) => LoginScreen(),
   // '/signup': (context) => SignUpScreen(),
  //},
 // initialRoute: '/login', // or your desired initial route
      ),
      home: const LoginScreen(),
    );
  }
}
