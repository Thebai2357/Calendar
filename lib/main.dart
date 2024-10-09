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
      //theme: ThemeData.dark(),
      home: const CalendarPage(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Calendar App',
//       theme: ThemeData.dark(),
//       home: CalendarPage()
//     );
//   }
// }
// class Event{
//   final String title;
//   Event(this.title);

//   @override
//   String toString() =>title;
// }

// class CalendarPage extends StatefulWidget{
//   @override
//   _CalendarPageState createState() =>_CalendarPageState();
// }

// class _CalendarPageState extends State<CalendarPage>{
//   DateTime _focusedDay = DateTime.now();
//   DateTime _selectedDay = DateTime.now();

//   Map<DateTime, List<Event>> _events = {};
//   List<Event> _getEventsForDay(DateTime day){
//     return _events[day] ?? [];
//   }

//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Calendar'),
//       ),
//       body: Column(
//         children: [
//           TableCalendar(
//             focusedDay: _focusedDay, 
//             firstDay: DateTime.utc(2000,1,1), 
//             lastDay: DateTime.utc(2100,12,31),
//             selectedDayPredicate: (day){
//               return isSameDay(_selectedDay, day);
//             },
//             eventLoader: _getEventsForDay,
//             onDaySelected: (selectedDay,focusedDay){
//               setState((){
//                 _selectedDay = selectedDay;
//                 _focusedDay  = focusedDay;
//               });
//             },
//           ),
//           Expanded(
//             child: ListView(
//               children: _getEventsForDay(_selectedDay ?? _focusedDay)
//               .map((event)=> ListTile(
//                 title: Text(event.title),
//               ))
//               .toList(),
//               ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _addEvent,
//         child: const Icon(Icons.add),
//         ),
//     );
//   }

//   void _addEvent(){
//     String eventTitle = '';
//     showDialog(
//       context: context, 
//       builder: (context) => AlertDialog(
//         title: const Text('予定を追加'),
//         content: TextField(
//           autofocus: true,
//           decoration: const InputDecoration(hintText:'予定を入力'),
//           onChanged:  (value){
//             eventTitle = value;
//           },
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//              child: const Text('cancel')
//           ),
//           TextButton(
//             onPressed: (){
//               if (eventTitle.isEmpty) return;
//               setState(() {
//                 if (_events[_selectedDay]!= null){
//                   _events[_selectedDay]!.add(Event(eventTitle));
//                 } else {
//                   _events[_selectedDay] = [Event(eventTitle)];
//                 }
//               });
//               Navigator.pop(context);
//             },
//             child: const Text('追加'),
//           ),
//         ],
//       ),
//     );
//   }
// }

