import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/event.dart';
import 'event_list_page.dart';
import 'add_event_dialog.dart';

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

  void _addEvent(Event event){
    setState(() {
      DateTime selectedDayOnly = _getDataOnly(_selectedDay);
      if (_events[selectedDayOnly] != null){
        _events[selectedDayOnly]!.add(event);
      }else{
        _events[selectedDayOnly] = [event];
      }
    });
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
                _selectedDay = _getDataOnly(selectedDay);
                _focusedDay  = _getDataOnly(focusedDay);
              });
            },
          ),
          Expanded(
            child: ListView(
              children: _getEventsForDay(_selectedDay)
              .map((event)=> ListTile(
                title: Text(event.title),
                subtitle: Text(
                  '${event.startTime.format(context)} - ${event.endTime.format(context)} @ ${event.location}'
                ),
              )).toList(),
              ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context,
            builder: (context) => AddEventDialog(
              onAddEvent: _addEvent,
            ),
          );
        },
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
}