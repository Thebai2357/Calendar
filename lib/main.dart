import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar App',
      theme: ThemeData.dark(),
      home: CalendarPage()
    );
  }
}

class CalendarPage extends StatefulWidget{
  @override
  _CalendarPageState createState() =>_CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>{
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: TableCalendar(
        firstDay: DateTime.utc(2000,1,1),
        lastDay: DateTime.utc(2100,12,31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day){
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay,focusedDay){
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){

      //   },
      //   child: Icon(Icons.add),
      // ),
    
    );
  }
}
