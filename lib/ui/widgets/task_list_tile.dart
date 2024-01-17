import 'package:flutter/material.dart';
import '../../data/models/task_list_mode.dart';
import '../screens/new_task_screen.dart';

class TaskListTile extends StatefulWidget {

  final VoidCallback onDeleteTap, onEditTap;

  //final VoidCallbackAction onDeleteTap, onEditTap;

  const TaskListTile({
    super.key,
    required this.data,
    required this.onDeleteTap,
    required this.onEditTap,
  });

  final TaskData data;

  @override
  State<TaskListTile> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {




  @override
  Widget build(BuildContext context) {

    final NewTaskScreen newTaskScreen = NewTaskScreen();

    return ListTile(
      title: Text(widget.data.title ?? 'UnKnown'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.data.description ?? ''),
          Text(widget.data.createdDate ?? ''),
          Row(
            children: [
              Chip(
                label: Text(
                  widget.data.status ?? 'New',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blue,
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                //onPressed: ,
                icon: const Icon(Icons.delete_forever_outlined),
                color: Colors.red.shade300,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                color: Colors.greenAccent,
              ),
            ],
          )
        ],
      ),
    );
  }
}