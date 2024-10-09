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
    final _titleController = TextEditingController();
    final _locationController = TextEditingController();
    TimeOfDay? _startTime;
    TimeOfDay? _endTime;

    showDialog(
      context: context, 
      builder: (context) => StatefulBuilder(
        builder: (context,setState){
          return AlertDialog(
            title: const Text('予定を追加'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(hintText: 'タイトルを入力'),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    TextButton(
                      onPressed: () async{
                        _startTime = await showTimePicker(
                          context: context, 
                          initialTime: TimeOfDay.now(),
                        );
                        if (_startTime != null){
                          setState(() {});
                        }
                      }, 
                      child: Text(
                        _startTime == null
                          ? '開始時間を選択'
                          : '開始: ${_startTime!.format(context)}',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () async{
                        _endTime = await showTimePicker(
                          context: context, 
                          initialTime: TimeOfDay.now(),
                        );
                        if (_endTime != null){
                          setState(() {});
                        }
                      }, 
                      child: Text(
                        _endTime == null
                          ? '終了時間を選択'
                          : '終了: ${_startTime!.format(context)}',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _locationController,
                  decoration: const InputDecoration(hintText: '場所を入力'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed:(){
                  if (_titleController.text.isEmpty||
                  _startTime == null||
                  _endTime == null||
                  _locationController.text.isEmpty){
                    return;
                  }
                  setState((){
                    DateTime selectedDayOnly = _getDataOnly(_selectedDay);
                    if (_events[selectedDayOnly] != null){
                      _events[selectedDayOnly]!.add(
                        Event(
                          title: _titleController.text, 
                          startTime: _startTime!, 
                          endTime: _endTime!, 
                          location: _locationController.text,
                        ),
                      );
                    }else{
                      _events[selectedDayOnly] = [
                        Event(
                          title: _titleController.text,
                          startTime: _startTime!,
                          endTime: _endTime!,
                          location: _locationController.text,
                        ),
                      ];
                    }
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('追加'),  
                ),
            ],
          );
        },
      ),
    );
  }

  // void _addEvent(){
  //   String eventTitle = '';
  //   showDialog(
  //     context: context, 
  //     builder: (context) => AlertDialog(
  //       title: const Text('予定を追加'),
  //       content: TextField(
  //         autofocus: true,
  //         decoration: const InputDecoration(hintText:'予定を入力'),
  //         onChanged:  (value){
  //           eventTitle = value;
  //         },
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //            child: const Text('cancel')
  //         ),
  //         TextButton(
  //           onPressed: (){
  //             if (eventTitle.isEmpty) return;
  //             setState(() {
  //               DateTime selectedDayOnly = _getDataOnly(_selectedDay);
  //               if (_events[selectedDayOnly]!= null){
  //                 _events[selectedDayOnly]!.add(Event(eventTitle));
  //               } else {
  //                 _events[selectedDayOnly] = [Event(eventTitle)];
  //               }
  //             });
  //             Navigator.pop(context);
  //           },
  //           child: const Text('追加'),
  //         ),
  //       ],
  //     ),
  //   );
  // } 
}