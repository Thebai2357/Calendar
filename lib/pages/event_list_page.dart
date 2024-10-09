import 'package:flutter/material.dart';
import '../models/event.dart';

class EventListPage extends StatelessWidget{
  final Map<DateTime,List<Event>> events;

  const EventListPage({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final sortedDates = events.keys.toList()..sort();

    return Scaffold(
      appBar: AppBar(
        title: const Text('全ての予定'),
      ),
      body: ListView.builder(
        itemCount: sortedDates.length,
        itemBuilder: (context,index){
          final data = sortedDates[index];
          final eventList = events[data] ?? [];

          return ExpansionTile(
            title: Text(
              '${data.year}-${data.month.toString().padLeft(2,'0')}-${data.day.toString().padLeft(2,'0')}',
            ),
            children: eventList.map((event){
              return ListTile(
                title: Text(event.title),
              );
            }).toList()
          );
        },
      ),
    );
  }
}