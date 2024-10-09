import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/event.dart';
import 'event_list_page.dart';

class CalendarPage extends StatefulWidget{
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>{
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  DateTime _getDataOnly(DateTime data){
    return DateTime.utc(data.year,data.month,data.day);
  }
  Map<DateTime, List<Event>> _events = {};
  List<Event> _getEventsForDay(DateTime day){
    return _events[_getDataOnly(day)] ?? [];
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _navigateToEventList,
            ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay, 
            firstDay: DateTime.utc(2000,1,1), 
            lastDay: DateTime.utc(2100,12,31),
            selectedDayPredicate: (day){
              return isSameDay(_selectedDay, day);
            },
            eventLoader: _getEventsForDay,
            onDaySelected: (selectedDay,focusedDay){
              setState((){
                _selectedDay = selectedDay;
                _focusedDay  = focusedDay;
              });
            },
          ),
          Expanded(
            child: ListView(
              children: _getEventsForDay(_selectedDay ?? _focusedDay)
              .map((event)=> ListTile(
                title: Text(event.title),
              ))
              .toList(),
              ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEvent,
        child: const Icon(Icons.add),
        ),
    );
  }
  void _navigateToEventList(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>EventListPage(events: _events)
      ),
    );
  }

  void _addEvent(){
    String eventTitle = '';
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text('予定を追加'),
        content: TextField(
          autofocus: true,
          decoration: const InputDecoration(hintText:'予定を入力'),
          onChanged:  (value){
            eventTitle = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
             child: const Text('cancel')
          ),
          TextButton(
            onPressed: (){
              if (eventTitle.isEmpty) return;
              setState(() {
                if (_events[_selectedDay]!= null){
                  _events[_selectedDay]!.add(Event(eventTitle));
                } else {
                  _events[_selectedDay] = [Event(eventTitle)];
                }
              });
              Navigator.pop(context);
            },
            child: const Text('追加'),
          ),
        ],
      ),
    );
  } 
}