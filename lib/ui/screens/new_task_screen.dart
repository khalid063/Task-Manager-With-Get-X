import 'package:flutter/material.dart';
import '../../data/models/network_response.dart';
import '../../data/models/summary_count_model.dart';
import '../../data/models/task_list_mode.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/screen_background.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_list_tile.dart';
import '../widgets/user_profile_app_bar.dart';
import 'package:http/http.dart';

import 'add_new_task_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {

  ///======================================== All Variables ===================================================================///
  bool _getCountSummaryInProgress = false;
  bool _getNewTaskInProgress = false;


  ///======================================== Init State Call =================================================================///
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // after widget buind
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCountSummary();
      getNewTasks();
    });
  }

  ///---------------------------------------- getCountSummary Function (Task Status Count) API Call ---------------------------///
  SummaryCountModel _summaryCountModel = SummaryCountModel();
  /// API call start
  Future<void> getCountSummary() async{
    _getCountSummaryInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.taskStatusCount);
    if (response.isSuccess) {
      _summaryCountModel = SummaryCountModel.fromJson(response.body!);
    }else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Summary Data get Failede!'),),);
      }
    }
    _getCountSummaryInProgress = false;
    if (mounted) {
      setState(() {});
    }

  }

  ///---------------------------------------- getNewTask() Function (/listTaskByStatus/New) API Call --------------------------///
  TaskListModel _taskListModel = TaskListModel();
  Future<void> getNewTasks() async {
    _getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.newTask);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
      print('get new task response 777 : ${_taskListModel.data?.length}');
    }else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(' get new task data Failede!'),),);
      }
    }
    _getNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  ///---------------------------------------- deleteTask() Function (url/deleteTask/id) API Call ------------------------------///
  Future<void> deleteTask(String taskId) async{
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.deleteTask(taskId));
    if (response.isSuccess) {
      //getNewTasks();
      _taskListModel.data!.removeWhere((element) => element.sId == taskId);     // task list model is the main data list of Task Screen
      if (mounted) {
        setState(() {});
      }
    }else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Deletion of task has been failed!'),
          ),
        );
      }
    }
  }

  ///---------------------------------------- updateTask() Function (url/updateTaskStatus/$id/$status) API Call ---------------///
  Future<void> updateTask(String taskId, String newStatus) async{
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.updateTask(taskId, newStatus));
    if (response.isSuccess) {
      //getNewTasks();
      //_taskListModel.data!.removeWhere((element) => element.sId == taskId);     // task list model is the main data list of Task Screen
      Navigator.pop(context);
      if (mounted) {
        setState(() {});
      }
    }else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Update task has been failed!'),
          ),
        );
      }
    }
  }

  ///---------------------------------------- updateTask() Function () API Call ------------------------------///

  ///================================================== Scaffold Part ========================================================///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Column(
          children: [
            ///---------------------------------------- user profile banner --------------------------------------------------///
            const UserProfileAppBar(),

            ///---------------------------------------- Task Summary Show ListView.builder -----------------------------------///
            _getCountSummaryInProgress
                ? Center(
              child: LinearProgressIndicator(),
            )
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                                height: 70,
                    width: double.infinity,
                    child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _summaryCountModel.data?.length ?? 0,
                                  itemBuilder: (context, index){
                    return SummaryCard(
                      title: _summaryCountModel.data![index].sId ?? 'New',
                      number: _summaryCountModel.data![index].sum ?? 0,
                    );
                                  }, separatorBuilder: (BuildContext context, int index) {
                                  return Divider(height: 4,);
                                 },
                                ),
                  ),
                ),

            ///---------------------------------------- New Task Show ListView.builder ----------------------------------------///
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  getNewTasks();
                  getCountSummary();
                },
                child: _getNewTaskInProgress
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        itemCount: _taskListModel.data?.length ?? 0,
                    itemBuilder: (context, index){

                          // return TaskListTile(
                          //     data: _taskListModel.data![index],
                          //   onDeleteTap: () {
                          //       deleteTask(_taskListModel.data![index].sId!);
                          //   },
                          //   onEditTap: () {  },
                          // );

                      return ListTile(
                        title: Text(_taskListModel.data![index].title ?? 'Unknown'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_taskListModel.data![index].description ?? ''),
                            Text(_taskListModel.data![index].createdDate ?? ''),
                            Row(
                              children: [
                              Chip(
                                label: Text(
                                  _taskListModel.data?[index].status ?? 'New',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.blue,
                              ),
                              Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        deleteTask(deleteTask(_taskListModel.data![index].sId!) as String);
                                      },
                                      icon: Icon(Icons.delete_forever_outlined),
                                      color: Colors.red.shade300,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        //showEditBottomSheet(_taskListModel.data![index]);
                                        showStatusUpDateBottomSheet(_taskListModel.data![index]);
                                      },
                                      icon: Icon(Icons.edit),
                                      color: Colors.greenAccent,
                                    ),
                                  ],
                            )
                          ],
                        ),
                      );

                    }, separatorBuilder: (BuildContext context, int index) {
                    return Divider(height: 4,);
                },),
              ),

            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewTaskScreen(),),);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  ///======================================== BottomSheet for Edit Task Option ==================================================///
  void showEditBottomSheet(TaskData task) {
    final TextEditingController _titleTEController = TextEditingController(text: task.title);
    final TextEditingController _descriptionTEController = TextEditingController(text: task.description);
    bool _updateTaskInProgress = false;

    ///-------------------------------------- UpdateTask API Call ---------------------------------------------------------------///
    Future<void> updateTask() async{
      _updateTaskInProgress = true;
      if (mounted) {
        setState(() {});
      }
      Map<String, dynamic> responseBody = {
        "title": _titleTEController.text.trim(),
        "description": _descriptionTEController.text.trim(),
        //"status":"New"
      };

      final NetworkResponse response = await NetworkCaller().postRequest(Urls.createTask, responseBody);

      _updateTaskInProgress = false;
      if (mounted) {
        setState(() {});
      }

      if (response.isSuccess) {
        _titleTEController.clear();
        _descriptionTEController.clear();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Task UpDated Successfullly!"),),);
        }
      }else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Task UpDate failed!"),),);
        }
      }

    }

    ///---------------------------------------- BottomSheet as Edit Task Form ----------------------------------------------------///
    showModalBottomSheet(
        isScrollControlled: true,                                       ///*** should be true
        context: context, builder: (context){
      return Padding(                                                   ///*** SingleChildScroolView will be covered with "Padding"
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),   ///*** padding will be take from "MediaQuery"
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Update Task',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close),
                        ),
                      ],
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: _titleTEController,
                  decoration: const InputDecoration(
                      hintText: 'Title'
                  ),
                ),
                const SizedBox(height: 8,),
                TextFormField(
                  maxLines: 4,
                  controller: _descriptionTEController,
                  decoration: const InputDecoration(
                      hintText: 'Description'
                  ),
                ),
                const SizedBox(height: 16,),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _updateTaskInProgress == false,
                    replacement: const Center(child: CircularProgressIndicator(),),
                    child: ElevatedButton(
                      onPressed: () {
                        updateTask();
                      },
                      child: const Text('UpDate'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  ///======================================== BottomSheet for Status UpDate Title or Task =======================================///
  void showStatusUpDateBottomSheet(TaskData task) {
    List<String> taskStatusList = ['New', 'Progress', 'Canceled', 'Completed'];
    String _selectedTask = task.status!.toLowerCase();

    showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        builder: (context){
      return StatefulBuilder(
        builder: (context, updateState) {
          return SizedBox(
            height: 400,
            child: Column(
              children: [
                  const Padding(
                    child: Text('Update Status'),
                    padding: EdgeInsets.all(10),
                  ),
                  Expanded(
                  child: ListView.builder(
                    itemCount: taskStatusList.length,
                      itemBuilder: (context, index){
                            return ListTile(
                              onTap: () {
                                _selectedTask = taskStatusList[index];
                                updateState(() {});
                              },
                              title: Text(taskStatusList[index].toUpperCase()),
                              trailing: _selectedTask == taskStatusList[index]
                                  ? Icon(Icons.check)
                                  : null,
                            );
                          }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(onPressed: (){
                    updateTask(task.sId!, _selectedTask);
                  }, child: Text('Update'),),
                ),
              ],
            ),
          );
        }
      );
        });
  }

}






