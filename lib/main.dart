import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fmfdts/screens/Dashboard.dart';
import 'package:fmfdts/screens/Login.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  late Box box;

  bool isLoggedIn = false;

  box = await Hive.openBox('data');

  if (box.get('token') != null) {
    isLoggedIn = true;
  runApp(const MyAppz());
   FlutterNativeSplash.remove();

  }else{

  runApp(const MyApp());
   FlutterNativeSplash.remove();


  }


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

class MyAppz extends StatelessWidget {
  const MyAppz({super.key});

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
      home: DashboardPage(newReg: 's',),
    );
  }
}
