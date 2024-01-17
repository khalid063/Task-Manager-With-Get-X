import 'package:flutter/material.dart';
import 'cancelled_task_screen.dart';
import 'completed_task_screen.dart';
import 'in_progress_task_screen.dart';
import 'new_task_screen.dart';

class BottomNavBaseScreen extends StatefulWidget {
  const BottomNavBaseScreen({super.key});

  @override
  State<BottomNavBaseScreen> createState() => _BottomNavBaseScreenState();
}

class _BottomNavBaseScreenState extends State<BottomNavBaseScreen> {

  int _selectedScreenIndex = 0;

  final List<Widget> _screens = const [
    NewTaskScreen(),
    InProgressTaskScreen(),
    CancelledTaskScreen(),
    CompletedTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedScreenIndex,
        selectedItemColor: Colors.greenAccent,
        showUnselectedLabels: true,
        unselectedLabelStyle: TextStyle(
          color: Colors.grey,
        ),
        onTap: (int index){
          _selectedScreenIndex = index;
          print(_selectedScreenIndex);
          if (mounted) {
            setState(() {});
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'New'),
          BottomNavigationBarItem(icon: Icon(Icons.account_tree), label: 'In Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.cancel_outlined), label: 'Cancle'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Completed'),
        ],
      ),
    );
  }
}
