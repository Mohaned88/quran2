//import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:quran/Models/database.dart';
import 'package:quran/Views/Pages/sora_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await QuranDB.initializeDatabase();
  QuranDB.retrive_sora();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SoraScreen(),
    );
  }
}
