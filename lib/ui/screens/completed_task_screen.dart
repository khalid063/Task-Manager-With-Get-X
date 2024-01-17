import 'package:flutter/material.dart';
import '../../data/models/network_response.dart';
import '../../data/models/task_list_mode.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/screen_background.dart';
import '../widgets/task_list_tile.dart';
import '../widgets/user_profile_app_bar.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {

  ///======================================== All Variables =============================================================================///
  bool _getCompletedTaskInProgress = false;

  ///======================================== init Sate Call ============================================================================///
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getInProgressTasks();
    });
  }

  ///---------------------------------------- getInProgressTask() Function (/listTaskByStatus/Progress) API Call -----------------------///
  TaskListModel _taskListModel = TaskListModel();
  Future<void> getInProgressTasks() async {
    _getCompletedTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.completedlTask);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
      print('get new task response 777 : ${_taskListModel.data?.length}');
    }else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(' In Progress tasks get data Failede!'),),);
      }
    }
    _getCompletedTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackground(
          child: Column(
            children: [
              const UserProfileAppBar(),
              Expanded(
                child: ListView.separated(
                  itemCount: _taskListModel.data?.length ?? 0,
                  itemBuilder: (context, index){
                    //return TaskListTile();
                    return TaskListTile(
                      data: _taskListModel.data![index],
                      onDeleteTap: () {},
                      onEditTap: () {},
                    );
                  }, separatorBuilder: (BuildContext context, int index) {
                  return const Divider(height: 4,);
                },),
              )
            ],
          ),
        )
    );
  }
}
