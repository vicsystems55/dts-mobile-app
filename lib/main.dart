import 'package:flutter/material.dart';
import 'package:fmfdts/screens/Login.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  await Hive.initFlutter();

  runApp(const MyApp());
  
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FMF-DTS',
      theme: ThemeData(
        // textTheme: const TextTheme(
        //   bodyLarge: TextStyle(fontFamily: 'Poppins'),
        //   bodyMedium: TextStyle(fontFamily: 'Poppins'),
        //   bodySmall: TextStyle(fontFamily: 'Poppins'),
        // ),
        fontFamily: 'Outfit',
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}


