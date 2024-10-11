import 'package:flutter/material.dart';
import '../models/event.dart';

class AddEventDialog extends StatefulWidget{
  final Function(Event) onAddEvent;

  const AddEventDialog({Key? key, required this.onAddEvent}) : super(key: key);

  @override
  _AddEventDialogState createState() => _AddEventDialogState();
}

class _AddEventDialogState extends State<AddEventDialog>{
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  @override
  Widget build(BuildContext context){
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
                  setState(() {});
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
                  setState(() {});
                }, 
                child: Text(
                  _endTime == null
                    ? '終了時間を選択'
                    : '終了: ${_endTime!.format(context)}',
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
            widget.onAddEvent(
              Event(
                title: _titleController.text,
                startTime: _startTime!,
                endTime: _endTime!,
                location: _locationController.text,
              ),
            );
            Navigator.pop(context);
          },
          child: const Text('追加'),  
        ),
      ],
    );
  }
}