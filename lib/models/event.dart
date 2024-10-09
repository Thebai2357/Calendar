import 'package:flutter/material.dart';

class Event{
  final String title;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String location;
  Event({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.location,
  });
  String _formatTime(TimeOfDay time){
    final hour = time.hour.toString().padLeft(2,'0');
    final minute = time.minute.toString().padLeft(2,'0');
    return '$hour:$minute';
  }

  @override
  String toString(){
    return '$title (${_formatTime(startTime)} - ${_formatTime(endTime)}) @ $location';
  }
}