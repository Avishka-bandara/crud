import 'package:findaddcustomer/screens/customer%20provider.dart';
import 'package:findaddcustomer/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCEnRDHsOyELg3P5rvxRHljpD__ZAlMSI8",
          appId: "1:874676108309:android:6160ffbd4b4ad9f55d621c",
          messagingSenderId: "874676108309",
          projectId: "addfindcustomer"));
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CustomerProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
