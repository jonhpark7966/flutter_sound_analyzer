import 'package:flutter/material.dart';
import 'MainPage.dart';

import 'mic_stream.dart';


MicStream gMicStream = new MicStream();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  gMicStream.startStreamAndProcess();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Router for Test',
      theme: ThemeData(
       primarySwatch: Colors.blue,
       brightness: Brightness.dark,
       visualDensity: VisualDensity.adaptivePlatformDensity,
        iconTheme: IconThemeData(size:30.0),
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
          headline2: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          bodyText2: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
      ),
      routes:{
        '/': (context) => MainPage(),
     },
    );
  }
}
