import 'package:flutter/material.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/user_profile_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  


  ///======================================== Add new Task API Call Start ========================================///
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();

  bool _addNewTaskInProgress = false;

  Future<void> addNewTask() async{
    _addNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> responseBody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status":"New"
    };

    final NetworkResponse response = await NetworkCaller().postRequest(Urls.createTask, responseBody);

    _addNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (response.isSuccess) {
      _titleTEController.clear();
      _descriptionTEController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Task Added Successfullly!"),),);
      }
    }else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Task Add failed!"),),);
      }
    }
    
  }
  ///======================================== Add new Task API Call End ========================================///
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UserProfileAppBar(),
            const SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add New Task',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: _titleTEController,
                    decoration: InputDecoration(
                        hintText: 'Title'
                    ),
                  ),
                  const SizedBox(height: 8,),
                  TextFormField(
                    maxLines: 4,
                    controller: _descriptionTEController,
                    decoration: InputDecoration(
                        hintText: 'Description'
                    ),
                  ),
                  const SizedBox(height: 16,),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _addNewTaskInProgress == false,
                      replacement: const Center(child: CircularProgressIndicator(),),
                      child: ElevatedButton(
                        onPressed: () {
                          addNewTask();
                          //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavBaseScreen()), (route) => false);
                        },
                        child: Icon(Icons.arrow_forward),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
