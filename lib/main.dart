import 'package:flutter/material.dart';
import 'pages/calendar_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'Calendar App',
      theme: ThemeData.dark(),
      home: const CalendarPage(),
    );
  }
}
